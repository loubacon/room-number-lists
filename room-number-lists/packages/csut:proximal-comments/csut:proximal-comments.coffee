csut_proximalComments_comments = new Mongo.Collection 'csut_proximalComments_comments'

Meteor.startup ->
  if Meteor.isServer
    csut_proximalComments_comments.remove {}
    csut_proximalComments_comments.insert {
      msg: 'This is a root comment'
      creator: 'user 1'
      creationDate: "Mon Mar 30 2015 03:40:20 GMT-0700 (PDT)"
      parentId: 'test-comment-box'
      _id: 'doggy'
    }
    csut_proximalComments_comments.insert {
      msg: 'This is another comment from the same person.  A little longer this time.'
      creator: 'user 1'
      creationDate: "Mon Mar 30 2015 03:41:39 GMT-0700 (PDT)"
      parentId: 'test-comment-box'
      _id: 'doggy2'
    }
    csut_proximalComments_comments.insert {
      msg: "I'm someone different!"
      creator: 'user 2'
      creationDate: "Mon Mar 30 2015 03:41:39 GMT-0700 (PDT)"
      parentId: 'test-comment-box'
      _id: 'doggy3'
    }
    csut_proximalComments_comments.insert {
      msg: "Are you sure about that?"
      creator: 'user 2'
      creationDate: "Mon Mar 30 2015 03:41:39 GMT-0700 (PDT)"
      parentId: 'doggy3'
      _id: 'doggy4'
    }
    csut_proximalComments_comments.insert {
      msg: "I used to be...."
      creator: 'user 2'
      creationDate: "Mon Mar 30 2015 03:44:40 GMT-0700 (PDT)"
      parentId: 'doggy4'
      _id: 'doggy5'
    }
    csut_proximalComments_comments.insert {
      msg: "I'm professional ^_^'"
      creator: 'user 1'
      creationDate: "Mon Mar 30 2015 03:45:46 GMT-0700 (PDT)"
      parentId: 'test-comment-box'
      _id: 'doggy6'
    }

Template.proximal_comments.helpers {
  'topLevelComments': -> 
    csut_proximalComments_comments.find({parentId: 'test-comment-box'}).fetch()
}