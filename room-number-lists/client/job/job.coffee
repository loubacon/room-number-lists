# RESUME
Template.job.created = ->
  @fsm = StateMachine.create {
    initial: 'listingOptions'
    events: [
      {name: 'beginDeletion', from: 'listingOptions', to: 'confirmDeletion'}
      {name: 'approveDeletion', from: 'confirmDeletion', to: 'listingOptions'}
      {name: 'denyDeletion', from: 'confirmDeletion', to: 'listingOptions'}
    ]
    callbacks: {
      onbeforebeginDeletion: (event, from, to, obj) ->
        unless obj?.run? and obj?.name? then return false
      onbeginDeletion: (event, from, to, obj) =>
        @maybeDeleteListId.set RoomNumberListClassMethods.genDataListId(obj)
        console.log "@maybeDeleteListId.get()"
        console.log @maybeDeleteListId.get()
    }
  }
  @maybeDeleteListId = new ReactiveVar undefined

Template.job.helpers {
  'isConfirmDeletion' : -> Template.instance().fsm.is 'confirmDeletion'
  'isState': (state, strTrue, strFalse) ->
    isState = Template.instance().fsm.is state
    switch
      when strTrue? and isState then return strTrue
      when strFalse? and not isState then return strFalse
      else return isState
  'creatorFormat': (s) -> s.split('@')[0]
  'dateFormat': (s) -> moment(s).format('dddd MMM, DD, YY, h:mm a')
  'maybeDeleteList' : -> 
    x = DataLists.findOne(Template.instance().maybeDeleteListId.get())
    console.log 'x'
    console.log x
    return x
}

Template.job.events {
  'click [href="delete"]': (e, t) ->
    e.preventDefault()
    t.fsm.beginDeletion e.currentTarget.dataset
  'click [href="cancelDeletion"]': (e, t) ->
    e.preventDefault()
    t.fsm.denyDeletion()
}