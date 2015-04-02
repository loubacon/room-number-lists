Template.displayChildren.helpers {
  'log': (x) -> console.log x

  'children': -> 
    Meteor.subscribe 'csut_proximalComments_comments', @parentId
    return csut_proximalComments_comments.find({parentId: @parentId}, {sort: {creationDate: 1}}).fetch()
}