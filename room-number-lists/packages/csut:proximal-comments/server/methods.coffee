Meteor.methods {
  'csut_proximalComments_comments.insert': (p) -> 
    csut_proximalComments_comments.insert {
      msg: p.msg
      creator: Meteor.user().emails[0].address
      creatorId: Meteor.userId()
      creationDate: Date.now()
      commentBoxId: p.commentBoxId
      parentId: p.parentId
    }
  'csut_proximalComments_comments.upsert': (p) -> 
    csut_proximalComments_comments.upsert p._id, {$set: {msg: p.msg}}
}