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