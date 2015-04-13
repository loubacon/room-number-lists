# define a validator to confirm that a property is an object
validate.validators.isObj = (value, options, key, attributes) -> 
  if validate.isObject value
    return undefined
  else
    return "should be an object"

# define a validator to confirm that a property is a string
validate.validators.isStr = (value, options, key, attributes) -> 
  if validate.isString value
    return undefined
  else
    return "should be a string"

# define the constraints for an Einfach initObj argument
initObjConstraints = {
  templateName: 
    presence: true
    isStr: true
    format: 
      pattern: /^.+$/
      message: 'must be a string of at least 1 character'
  templateInstance:
    presence: true
    isObj: true
  stateFields:
    presence: true
    isObj: true
  transitions:
    presence: true
    isObj: true
}

validateInitObj = (initObj) ->
  # validate initialization parameter
  o = validate initObj, initObjConstraints

  # log errors encountered when validating initObj
  if o?
    console.error "Einfach initialization argument errors"
    console.error o
  
  # if there are errors, return them, else return undefined
  if o? then return o else return undefined


createReactiveVars = (initObj, stateFieldNames) ->
  # f: take a key, pin a ReactiveVar to template at key, initialize RV to initObj.stateFields[key]
  f = (key) -> 
    template = initObj.templateInstance
    initialValue = initObj.stateFields[key]
    template[key] = new ReactiveVar initialValue
  # iterate to pin var on template for each property in initObj.stateFields
  R.forEach f, stateFieldNames

writeHelpers = (initObj, stateFieldNames) ->
  f = (key) ->
    obj = {}
    obj[key] = -> Template.instance()[key].get()
    Template[ initObj.templateName ].helpers obj
  # iterate to over stateFields, auto-genning helpers
  R.forEach f, stateFieldNames

updateState = (initObj, stateFieldNames, newStateObj) ->

  set = (key, value) ->
    templateVar = initObj.templateInstance[ key ]
    templateVar.set value

  # present = array of strings representing the variables being explicity updated
  present = R.keys newStateObj
  # absent = array of strings representing the variables not being explicitly updated
  absent = R.difference stateFieldNames, present

  # helper functions
  update = (k) -> set k, newStateObj[k]
  clear = (k) -> set k, undefined

  R.forEach update, present
  R.forEach clear, absent

# define the Einfach function
#   which takes an initObj, containing:
#     templateName
#     templateInstance
#     stateFields
#     transitions
#   and does the following:
#     creates a ReactiveVar for each key in the stateFields object
#       initializing the ReactiveVar to the value passed in stateFields for that key
#     automatically creates a template helper with the same name as the stateFields key
#     binds each function in the transitions object to the transitionsApi
#       and makes these bound transitions available in the api object returned
#     returns an api object for event handlers code to utilize
Einfach = (initObj) ->

  # ___________________________________________________________________________  
  # initObj Validation
  #   initErrors gets one of two values
  #     {error object} if there are errors when validating
  #     undefined if there are no errors
  initErrors = validateInitObj initObj

  # ___________________________________________________________________________  
  # process stateFields
  stateFieldNames = R.keys(initObj.stateFields)

  # (1)
  # create a ReactiveVar for each stateField,
  createReactiveVars initObj, stateFieldNames

  # (2)
  # write a template helper for each property in initObj.stateFields
  writeHelpers initObj, stateFieldNames

  # ___________________________________________________________________________  
  # write a special stateIs helper to compare a string argument to the current value of
  # the templates reactive state variable
  Template[ initObj.templateName ].helpers {
    stateIs: (str) -> Template.instance().state.get() is str
  }

  # ___________________________________________________________________________  
  # write a special stateIfElse helper to compare a string to the state field
  # if they are the same, argument 1 is returned, if different, aregument 2 is returned
  Template[ initObj.templateName ].helpers {
    stateIfElse: (str, arg1, arg2) -> 
      if Template.instance().state.get() is str then return arg1 else return arg2
  }

  # ___________________________________________________________________________  
  # write a special log helper that logs its argument to the console
  Template[ initObj.templateName ].helpers {
    log: (x) -> console.log x
  }

  # ___________________________________________________________________________  
  # create a transitionApi object
  #   this will server as the context for calling transition functions
  #   giving them access to updating encapsulated state vars
  transitionApi = {
    to: (newStateObj) -> updateState initObj, stateFieldNames, newStateObj
  }

  # ___________________________________________________________________________  
  # create an api object
  api = {
    # take each function passed to initObj.transitions
    # and bind it's context to transitionApi
    transitions: R.mapObj ((x) -> x.bind transitionApi), initObj.transitions
  }
  
  return api
    
@Einfach = Einfach

###
Example usage code:

Template.blueprint.onCreated ->
  @ein = Einfach {
    templateName: 'blueprint'
    templateInstance: this
    stateFields: {
      msg: "This is the super cool message you have been waiting for."
      error: 'incorrect error'
      x: undefined
      state: 'displayMessage'
    }
    transitions: {
      toDisplayMessage: (p) -> @to {state: 'displayMessage', msg: p.msg}
      toError: (p) -> @to {state: 'error', error: p.error}
      toEgg: (p) -> @to {state: 'egg', x: 555}
    }
  }

Template.blueprint.events {
  'click .finishMessage' : (e, t) ->
    e.preventDefault()
    t.ein.transitions.toError {error: '********This is a crazy error**********'}

  'click .wantEaster': (e, t) ->
    e.preventDefault()
    t.ein.transitions.toEgg()

  'click .clearError': (e, t) ->
    e.preventDefault()
    t.ein.transitions.toDisplayMessage {msg: 'we are back, with a brand new message.'}
  'click .easterEgg': (e, t) ->
    e.preventDefault()
    t.ein.transitions.toDisplayMessage {msg: 'how did you enjoy the easter egg?'}
}
###