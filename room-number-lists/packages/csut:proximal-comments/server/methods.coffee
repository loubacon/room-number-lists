# genId = (pid) -> # pass a parentId in order to get your id
#   padDigits = (number, digits) ->
#     return Array(Math.max(digits - String(number).length + 1, 0)).join(0) + number

#   mongoID = new Mongo.ObjectID()
#   prefix = padDigits Date.now(), 15
#   hexString = mongoID.toHexString()
#   id = [prefix, hexString].join "-"
#   return [pid, id].join "/"

Meteor.methods {
  'csut_proximalComments_comments.insert': (p) -> 
    if Meteor.user() #only do an insert if user is loggedIn
      csut_proximalComments_comments.insert {
        # _id: genId p.parentId
        msg: p.msg
        creator: Meteor.user().emails[0].address
        creatorId: Meteor.userId()
        creationDate: Date.now()
        commentBoxId: p.commentBoxId
        parentId: p.parentId
        # replyLevel: genId(p.parentId).split('/').length - 2 # elements with length 2 would be root replies
      }
  'csut_proximalComments_comments.upsert': (p) -> 
    if Meteor.user() #only do an upsert if user is loggedIn
      csut_proximalComments_comments.upsert p._id, {$set: {msg: p.msg}}
}