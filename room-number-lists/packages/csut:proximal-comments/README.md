need to store currentState and targetComment under commentboxId namesapced session variables

- List App Features
  - allow discussion in-place in a website (comments, replies, users)
  - track unread messages for users
  - fold up to become an unobtrusive widget when not needed for review
- Define Data Structures used in app
  - Comment
    -_id
    - msg (text for now, html in future, maybe markdown)
    - creator (user _id)
    - creationDate (Date().toString())
    - parentId (_id of comment or proximal-comments box that this comment is "attached" to)
- Define Collections used in app
  - csut_proximalComments_comments
    - all comments (replies are comments) go here
- Define Server methods used in app
- Define URLs used in app
- Define GUI components used in app
- Define State Machines used in app
  * minimized and maximized states are NOT managed by the comments, that is a parameter on the template when it is called (probably based on a reactive var in container)
  - listComments
  - showCommentMenu (@targetComment)
  - createTopLevelComment
  - confirmTopLevelComment
  - createReplyComment
  - confirmReplyComment
  - editTopLevelComment
  - confirmEditTopLevelComment
  - editReplyComment
  - confirmEditReplyComment
- Create Mock Data
mockData = [
  {
    msg: 'This is a root comment'
    creator: 'user 1'
    creationDate: "Mon Mar 30 2015 03:40:20 GMT-0700 (PDT)"
    parentId: 'test-comment-box'
    _id: 'doggy'
  }
  {
    msg: 'This is another comment from the same person.  A little longer this time.'
    creator: 'user 1'
    creationDate: "Mon Mar 30 2015 03:41:39 GMT-0700 (PDT)"
    parentId: 'test-comment-box'
    _id: 'doggy2'
  }
  {
    msg: "I'm someone different!"
    creator: 'user 2'
    creationDate: "Mon Mar 30 2015 03:41:39 GMT-0700 (PDT)"
    parentId: 'test-comment-box'
    _id: 'doggy3'
  }
  {
    msg: "Are you sure about that?"
    creator: 'user 2'
    creationDate: "Mon Mar 30 2015 03:41:39 GMT-0700 (PDT)"
    parentId: 'doggy3'
    _id: 'doggy4'
  }
  {
    msg: "I used to be...."
    creator: 'user 2'
    creationDate: "Mon Mar 30 2015 03:44:40 GMT-0700 (PDT)"
    parentId: 'doggy4'
    _id: 'doggy5'
  }
  {
    msg: "I'm professional ^_^'"
    creator: 'user 1'
    creationDate: "Mon Mar 30 2015 03:45:46 GMT-0700 (PDT)"
    parentId: 'test-comment-box'
    _id: 'doggy6'
  }
]

stage 1: