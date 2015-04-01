Template.comment.helpers {
  'shouldShowMenu': -> 
    target = Session.get "#{@commentBoxId}_targetComment"
    currentState = Session.get "#{@commentBoxId}_currentState" 
    console.log "target #{target}, currentState #{currentState}"
    target is @_id and currentState is 'listComments'
}

Template.comment.events {
  'click': (e, t) -> Session.set "#{t.data.commentBoxId}_targetComment", t.data._id
}