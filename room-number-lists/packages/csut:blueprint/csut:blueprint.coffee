if Meteor.isServer
  Meteor.methods {
    'csut_blueprint_verifyPassword': (s) -> s is 'spookylouie'
  }
if Meteor.isClient
  Template.csut_blueprint.created = ->
    @fsm = StateMachine.create {
      initial: 'requestPassword'
      events: [
        {name: 'checkPassword', from: ['requestPassword', 'tryAgain'], to: 'verifying'}
        {name: 'authorize', from: 'verifying', to: 'displayBlueprint'}
        {name: 'reject', from: 'verifying', to: 'tryAgain'}
      ]
      callbacks: {
        oncheckPassword: (event, from, to, str, fsm) ->
          Meteor.call 'csut_blueprint_verifyPassword', str, (error, result) ->
            if result is true 
              fsm.authorize()
            else
              fsm.reject()
      }
    }

  Template.csut_blueprint.helpers {
    'currentState': -> Template.instance().fsm.current.get()
  }

  Template.csut_blueprint.events {
    'submit form' : (e, t) ->
      e.preventDefault()
      # gather inputs into formObj
      formObj = csut.objectifyForm t.$('form')
      # check password
      t.fsm.checkPassword formObj.password, t.fsm
  }