Template.displayChildren.helpers {
  'children': -> 
    Meteor.subscribe 'csut_proximalComments_comments', @parentId
    return csut_proximalComments_comments.find({parentId: @parentId}).fetch()
}