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
    toShowReplyForm: (commentId, replyMsg) -> # accepts a replyMsg because this function can be called for initial reply creation, or reply editing
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
    toShowRootReplyForm: (replyMsg) ->
      newState = {
        current: 'showRootReplyForm'
        replyMsg: replyMsg or ''
      }
      Session.set "#{commentBoxId}_state", JSON.stringify(newState)
      return API
    toConfirmRootReplyMessage: (replyMsg) ->
      newState = {
        current: 'confirmRootReplyMessage'
        replyMsg: replyMsg
      }
      Session.set "#{commentBoxId}_state", JSON.stringify(newState)
      return API
    toPostReply: (p) ->
      Meteor.call 'csut_proximalComments_comments.insert', p, ->
        API.toListComments()
    getCurrentState: -> 
      JSON.parse Session.get("#{commentBoxId}_state")
  }
  return API