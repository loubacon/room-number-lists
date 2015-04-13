nodes = [
  {_id: "B", pid: "A"}
  {_id: "C", pid: "A"}
  {_id: "D", pid: "B"}
  {_id: "E", pid: "B"}
  {_id: "F", pid: "B"}
  {_id: "H", pid: "C"}
  {_id: "I", pid: "C"}
  {_id: "J", pid: "C"}
  {_id: "G", pid: "E"}
  {_id: "K", pid: "J"}
  {_id: "L", pid: "J"}
]

cmp = (a, b) -> 
  switch
    when a._id < b._id then -1
    when a._id > b._id then 1
    else 0
    
tree = treeify {
  rootNode: {_id: "A", children:[]}
  nodes: nodes
  comparator: cmp
  pidProp: 'pid'
}

Tinytest.add 'example', (test) ->
  test.equal true, true
  

Tinytest.add "tree.root?._id", (test) ->
  test.equal tree.root?._id, "A"
Tinytest.add "tree.root?.children?.length", (test) ->
  test.equal tree.root?.children?.length, 2
Tinytest.add "tree.root?.children[0]?._id", (test) ->
  test.equal tree.root?.children[0]?._id, "B"
Tinytest.add "tree.root?.children[0]?.children?.length", (test) ->
  test.equal tree.root?.children[0]?.children?.length, 3
Tinytest.add "tree.root?.children[0]?.children[1]?.children[0]?._id", (test) ->
  test.equal tree.root?.children[0]?.children[1]?.children[0]?._id, "G"
Tinytest.add "tree.root?.children[1]?.children[2]?.children[1]?._id", (test) ->
  test.equal tree.root?.children[1]?.children[2]?.children[1]?._id, "L"

Tinytest.add 'independent node list ordering', (test) ->
  nodes = [
    {_id: "B", pid: "A"}
    {_id: "C", pid: "A"}
    {_id: "D", pid: "B"}
    {_id: "E", pid: "B"}
    {_id: "F", pid: "B"}
    {_id: "H", pid: "C"}
    {_id: "I", pid: "C"}
    {_id: "J", pid: "C"}
    {_id: "G", pid: "E"}
    {_id: "K", pid: "J"}
    {_id: "L", pid: "J"}
  ]
  nodes2 = [
    {_id: "H", pid: "C"}
    {_id: "I", pid: "C"}
    {_id: "J", pid: "C"}
    {_id: "D", pid: "B"}
    {_id: "C", pid: "A"}
    {_id: "E", pid: "B"}
    {_id: "F", pid: "B"}
    {_id: "G", pid: "E"}
    {_id: "K", pid: "J"}
    {_id: "L", pid: "J"}
    {_id: "B", pid: "A"}
  ]
  

  # tree = treeify {_id: "A", children:[]}, nodes
  tree = treeify {
    rootNode: {_id: "A", children:[]}
    nodes: nodes
    comparator: cmp
    pidProp: 'pid'
  }
  # tree2 = treeify {_id: "A", children:[]}, nodes2
  tree2 = treeify {
    rootNode: {_id: "A", children:[]}
    nodes: nodes2
    comparator: cmp
    pidProp: 'pid'
  }

  # // test "tree.root?._id", tree.root?._id, "A"
  test.equal tree.root?._id, tree2.root?._id
  # // test "tree.root?.children?.length", tree.root?.children?.length, 2
  test.equal tree.root?.children?.length, tree2.root?.children?.length
  # # # // test "tree.root?.children[0]?._id", tree.root?.children[0]?._id, "B"
  test.equal tree.root?.children[0]?._id, tree2.root?.children[0]?._id
  # # # // test "tree.root?.children[0]?.children?.length", tree.root?.children[0]?.children?.length, 3
  test.equal tree.root?.children[0]?.children?.length, tree2.root?.children[0]?.children?.length
  # # # // test "tree.root?.children[0]?.children[1]?.children[0]?._id", tree.root?.children[0]?.children[1]?.children[0]?._id, "G"
  test.equal tree.root?.children[0]?.children[1]?.children[0]?._id, tree2.root?.children[0]?.children[1]?.children[0]?._id
  # # # // test "tree.root?.children[1]?.children[2]?.children[1]?._id", tree.root?.children[1]?.children[2]?.children[1]?._id, "L"
  test.equal tree.root?.children[1]?.children[2]?.children[1]?._id, tree2.root?.children[1]?.children[2]?.children[1]?._id
