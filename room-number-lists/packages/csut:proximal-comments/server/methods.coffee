Meteor.methods {
  'csut_proximalComments_comments.insert': (p) -> 
    csut_proximalComments_comments.insert {
      msg: p.msg
      creator: 'dummycreator'
      creationDate: (new Date()).toString()
      commentBoxId: p.commentBoxId
      parentId: p.parentId
    }
}