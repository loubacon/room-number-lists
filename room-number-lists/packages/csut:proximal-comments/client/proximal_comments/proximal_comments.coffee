Template.proximal_comments.onCreated ->
  ISM(@data.commentBoxId).toListComments()

Template.proximal_comments.helpers {
  'shouldShowRootReplyForm': -> ISM(@commentBoxId).getCurrentState().current is 'showRootReplyForm'
  'getReplyFormMessage': -> ISM(@commentBoxId).getCurrentState().replyMsg
  'shouldConfirmRootReplyMessage': -> ISM(@commentBoxId).getCurrentState().current is 'confirmRootReplyMessage'
}

Template.proximal_comments.events {
  'click [href="replyRoot"]': (e, t) -> 
    e.preventDefault()
    # console.log 'click [href="replyRoot"]'
    ISM(t.data.commentBoxId).toShowRootReplyForm()

  'submit .rootReplyForm': (e, t) ->
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
