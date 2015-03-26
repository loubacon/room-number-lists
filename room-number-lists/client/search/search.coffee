formConstraints =
  job: 
    presence: true
    format: 
      pattern: /^\d{5}$/
      message: 'must be a five digit integer'

Template.search.created = ->
  @fsm = StateMachine.create {
    initial: 'invalid'
    events: [
      {name: 'validate', from: 'invalid', to: 'valid'}
      {name: 'connect', from: 'valid', to: 'connecting'}
    ]
    callbacks: {
      onbeforevalidate: (event, from, to, form) =>
        errors = validate form, formConstraints
        if errors?
          # if form is invalid set errors, return false to cancel transition
          @errors.set errors
          @job.set undefined
          return false
        else
          # clear errors
          @errors.set []
          # if form is valid set job to job#
          @job.set form.job
      onvalid: =>
        @fsm.connect @job.get()
      onconnecting: (event, from, to, job) =>
        Meteor.subscribe 'DataLists', job, -> #onReady callback
          Router.go 'job', {job: job}
        
    }
  }
  @errors = new ReactiveVar []
  @job = new ReactiveVar undefined


Template.search.helpers {
  'errors': -> Template.instance().errors.get()
  'job': -> Template.instance().job.get()
  'whenConnecting': (str) -> 
    isConnecting = Template.instance().fsm.is 'connecting'
    if str? # if an argument was passed in as str...
      return str if isConnecting #return that arg, if isConnecting is true
    else # if no argument was passed, or str is non-existant
      return isConnecting # return the boolean value from isConnecting
}

Template.search.events {
  'submit form': (e, t) ->
    e.preventDefault()
    # call validate, passing an objectified verion of form
    t.fsm.validate csut.objectifyForm(t.$('form'))
}