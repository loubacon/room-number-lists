Template.proximal_comments.onCreated ->
  Session.set "#{@data.commentBoxId}_targetComment", undefined
  Session.set "#{@data.commentBoxId}_currentState", 'listComments'