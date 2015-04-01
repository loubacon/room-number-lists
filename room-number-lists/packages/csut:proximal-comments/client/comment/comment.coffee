Template.comment.helpers {
  'shouldShowMenu': -> 
    state = ISM(@commentBoxId).getCurrentState()
    state.target is @_id and state.current is 'showCommentMenu'


  'shouldShowReplyForm': -> 
    state = ISM(@commentBoxId).getCurrentState()
    state.target is @_id and state.current is 'showReplyForm'

  'shouldConfirmReplyMessage': ->
    state = ISM(@commentBoxId).getCurrentState()
    state.target is @_id and state.current is 'confirmReplyMessage'

  'getReplyFormMessage': -> ISM(@commentBoxId).getCurrentState().replyMsg
}

Template.comment.events {
  'click .commentMenu [href="edit"]': (e, t) -> 
    e.preventDefault()
    console.log 'click [href="edit"]'
  'click [href="reply"]': (e, t) -> 
    e.preventDefault()
    ISM(t.data.commentBoxId).toShowReplyForm t.data._id
  'click [href="toggleMenu"]': (e, t) -> 
    e.preventDefault()
    ISM t.data.commentBoxId
      .toShowCommentMenu t.data._id
  'submit .replyForm': (e, t) ->
    e.preventDefault()
    formObj = csut.objectifyForm(t.$('form'))
    ISM(t.data.commentBoxId)
      .toConfirmReplyMessage t.data._id, formObj.message
  'click .replyForm [href="cancel"]': (e, t) ->
    e.preventDefault()
    ISM(t.data.commentBoxId).toListComments()
  'submit .confirmReplyMessageForm': (e, t) ->
    e.preventDefault()
    confirmedMsg = ISM(t.data.commentBoxId).getCurrentState().replyMsg
    ISM(t.data.commentBoxId)
      .toPostReply {
        msg: confirmedMsg
        parentId: t.data._id
        commentBoxId: t.data.commentBoxId
      }
  'click .confirmReplyMessage [href="cancel"]': (e, t) ->
    e.preventDefault()
    ISM(t.data.commentBoxId).toListComments()
  'click .confirmReplyMessage [href="edit"]': (e, t) ->
    e.preventDefault()
    oldState = ISM(t.data.commentBoxId).getCurrentState()
    ISM t.data.commentBoxId
      .toShowReplyForm t.data._id, oldState.replyMsg # pass along replyMsg
}