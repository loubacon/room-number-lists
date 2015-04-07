treeify = (p) ->
  #p = {rootNode, nodes, comparator, pidProp}
  p.nodes = R.sort p.comparator, p.nodes
  children = R.groupBy R.prop(p.pidProp), p.nodes
  getChildren = (node) ->
    if not children[node.id]?
      node.children = []
      return node
    else
      node.children = R.forEach getChildren, children[node.id]
      return node
  return {
    root: getChildren p.rootNode
  }

@treeify = treeify

###
treeify needs some sort of children sorting in order to produce identical results regardless of order that nodes array is in
it needs to sort nodes, mayb by a sort field?
###