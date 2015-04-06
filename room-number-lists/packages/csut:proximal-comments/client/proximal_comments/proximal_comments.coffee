Template.proximal_comments.onCreated ->
  ISM(@data.commentBoxId).toListComments()

Template.proximal_comments.helpers {
  'childComments': -> 
    Meteor.subscribe 'csut_proximalComments_comments', @commentBoxId
    xs = csut_proximalComments_comments.find({commentBoxId: @commentBoxId}).fetch()
    f = (o) =>
      o.unlocked = @unlocked
      o.userId = @userId
      return o
    xs = R.map f, xs
    xs = R.sortBy R.prop('_id'), xs
    console.log xs
    return xs

  'shouldShowRootReplyForm': -> ISM(@commentBoxId).getCurrentState().current is 'showRootReplyForm'
  # 'getReplyFormMessage': -> ISM(@commentBoxId).getCurrentState().replyMsg
  'replyToRootForm_dataContext' : -> return {msg: ISM(@commentBoxId).getCurrentState().replyMsg}
  'shouldConfirmRootReplyMessage': -> ISM(@commentBoxId).getCurrentState().current is 'confirmRootReplyMessage'
}

Template.proximal_comments.events {
  'click .replyToRoot [href="replyToRoot"]': (e, t) -> 
    e.preventDefault()
    # console.log 'click [href="replyRoot"]'
    ISM(t.data.commentBoxId).toShowRootReplyForm()

  'submit .replyToRootForm form': (e, t) ->
    e.preventDefault()
    formObj = csut.objectifyForm(t.$('form'))
    ISM(t.data.commentBoxId)
      .toConfirmRootReplyMessage formObj.message
  'click .rootReplyForm [href="cancel"]': (e, t) ->
    e.preventDefault()
    ISM(t.data.commentBoxId).toListComments()
  'submit .confirmRootReplyMessageForm': (e, t) ->
    e.preventDefault()
    confirmedMsg = ISM(t.data.commentBoxId).getCurrentState().replyMsg
    ISM(t.data.commentBoxId)
      .toPostReply {
        msg: confirmedMsg
        parentId: t.data.commentBoxId
        commentBoxId: t.data.commentBoxId
      }
  'click .confirmRootReplyMessage [href="cancel"]': (e, t) ->
    e.preventDefault()
    ISM(t.data.commentBoxId).toListComments()
  'click .confirmRootReplyMessage [href="edit"]': (e, t) ->
    e.preventDefault()
    oldState = ISM(t.data.commentBoxId).getCurrentState()
    ISM t.data.commentBoxId
      .toShowRootReplyForm oldState.replyMsg # pass along replyMsg
}
