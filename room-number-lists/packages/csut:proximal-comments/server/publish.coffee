Meteor.publish 'csut_proximalComments_comments', (commentBoxId) ->
  return csut_proximalComments_comments.find({commentBoxId: commentBoxId})