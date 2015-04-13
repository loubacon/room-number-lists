Template.proximal_comments.onCreated ->
  ISM(@data.commentBoxId).toListComments()

Template.proximal_comments.helpers {
  'childComments': -> 
    Meteor.subscribe 'csut_proximalComments_comments', @commentBoxId
    xs = csut_proximalComments_comments.find({commentBoxId: @commentBoxId}).fetch()
    # build out a tree structure from flat data returned by collection
    tree = treeify {
      rootNode: {_id: @commentBoxId, children:[]}
      nodes: xs
      comparator: R.comparator (a, b) -> a.creationDate < b.creationDate
      pidProp: 'parentId'
    }
    # empty array to catch our traversal results
    xs1 = []
    # function called on each node during traversal
    f = (x) ->
      obj = x.data
      obj.replyLevel = x.depth
      xs1.push obj
    # generate a shiny Arboreal tree from our lowly tree structure
    arb = Arboreal.parse(tree.root, 'children')
    # traverse our arboreal tree (depth first) adding each node to our xs1 array
    # xs will be a flat array again, but now arranged in proper psuedo-tree order
    arb.traverseDown f
    return R.tail xs1 # snip off the root node

  'shouldShowRootReplyForm': -> ISM(@commentBoxId).getCurrentState().current is 'showRootReplyForm'
  # 'getReplyFormMessage': -> ISM(@commentBoxId).getCurrentState().replyMsg
  'replyToRootForm_dataContext' : -> return {msg: ISM(@commentBoxId).getCurrentState().replyMsg}
  'shouldConfirmRootReplyMessage': -> ISM(@commentBoxId).getCurrentState().current is 'confirmRootReplyMessage'
}

Template.proximal_comments.events {
  'click .replyToRoot [href="replyToRoot"]': (e, t) -> 
    e.preventDefault()
    # console.log 'click [href="replyRoot"]'
    ISM(t.data.commentBoxId).toShowRootReplyForm()

  'submit .replyToRootForm form': (e, t) ->
    e.preventDefault()
    formObj = csut.objectifyForm(t.$('form'))
    ISM(t.data.commentBoxId)
      .toConfirmRootReplyMessage formObj.message
  'click .rootReplyForm [href="cancel"]': (e, t) ->
    e.preventDefault()
    ISM(t.data.commentBoxId).toListComments()
  'submit .confirmRootReplyMessageForm': (e, t) ->
    e.preventDefault()
    confirmedMsg = ISM(t.data.commentBoxId).getCurrentState().replyMsg
    ISM(t.data.commentBoxId)
      .toPostReply {
        msg: confirmedMsg
        parentId: t.data.commentBoxId
        commentBoxId: t.data.commentBoxId
      }
  'click .confirmRootReplyMessage [href="cancel"]': (e, t) ->
    e.preventDefault()
    ISM(t.data.commentBoxId).toListComments()
  'click .confirmRootReplyMessage [href="edit"]': (e, t) ->
    e.preventDefault()
    oldState = ISM(t.data.commentBoxId).getCurrentState()
    ISM t.data.commentBoxId
      .toShowRootReplyForm oldState.replyMsg # pass along replyMsg
}
