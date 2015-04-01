Meteor.methods {
  'csut_proximalComments_comments.insert': (p) -> 
    console.log 'csut_proximalComments_comments.insert'
    csut_proximalComments_comments.insert {
      msg: p.msg
      creator: 'dummycreator'
      creationDate: (new Date()).toString()
      commentBoxId: p.commentBoxId
      parentId: p.parentId
    }
}