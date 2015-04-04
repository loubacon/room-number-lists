Template.displayChildren.helpers {
  'log': (x) -> console.log x

  'children': -> 
    Meteor.subscribe 'csut_proximalComments_comments', @parentId
    xs = csut_proximalComments_comments.find({parentId: @parentId}, {sort: {creationDate: 1}}).fetch()
    f = (o) =>
      o.unlocked = @unlocked
      o.userId = @userId
      return o
    xs = R.map f, xs
    console.log xs
    return xs
}