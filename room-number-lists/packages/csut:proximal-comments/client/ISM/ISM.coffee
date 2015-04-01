@ISM = (commentBoxId) ->

  API = {
    toShowCommentMenu: (commentId) ->
      oldState = API.getCurrentState()
      newState = {
        current: 'showCommentMenu'
        target: if commentId isnt oldState.target then commentId else undefined
      }
      Session.set "#{commentBoxId}_state", JSON.stringify(newState)
      return API
    toListComments: -> 
      newState = {
        current: 'listComments'
      }
      Session.set "#{commentBoxId}_state", JSON.stringify(newState)
      return API
    toShowReplyForm: (commentId, replyMsg) -> 
      newState = {
        current: 'showReplyForm'
        target: commentId
        replyMsg: replyMsg or ''
      }
      Session.set "#{commentBoxId}_state", JSON.stringify(newState)
      return API
    toConfirmReplyMessage: (commentId, replyMsg) ->
      newState = {
        current: 'confirmReplyMessage'
        target: commentId
        replyMsg: replyMsg
      }
      Session.set "#{commentBoxId}_state", JSON.stringify(newState)
      return API
    getCurrentState: -> 
      JSON.parse Session.get("#{commentBoxId}_state")
  }
  return API