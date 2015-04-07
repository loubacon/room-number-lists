nodes = [
  {id: "B", pid: "A"}
  {id: "C", pid: "A"}
  {id: "D", pid: "B"}
  {id: "E", pid: "B"}
  {id: "F", pid: "B"}
  {id: "H", pid: "C"}
  {id: "I", pid: "C"}
  {id: "J", pid: "C"}
  {id: "G", pid: "E"}
  {id: "K", pid: "J"}
  {id: "L", pid: "J"}
]
tree = treeify {
  rootNode: {id: "A", children:[]}
  nodes: nodes
  comparator: cmp
  pidProp: 'pid'
}
cmp = (a, b) -> 
  switch
    when a.id < b.id then -1
    when a.id > b.id then 1
    else 0

Tinytest.add 'example', (test) ->
  test.equal true, true
  

Tinytest.add "tree.root?.id", (test) ->
  test.equal tree.root?.id, "A"
Tinytest.add "tree.root?.children?.length", (test) ->
  test.equal tree.root?.children?.length, 2
Tinytest.add "tree.root?.children[0]?.id", (test) ->
  test.equal tree.root?.children[0]?.id, "B"
Tinytest.add "tree.root?.children[0]?.children?.length", (test) ->
  test.equal tree.root?.children[0]?.children?.length, 3
Tinytest.add "tree.root?.children[0]?.children[1]?.children[0]?.id", (test) ->
  test.equal tree.root?.children[0]?.children[1]?.children[0]?.id, "G"
Tinytest.add "tree.root?.children[1]?.children[2]?.children[1]?.id", (test) ->
  test.equal tree.root?.children[1]?.children[2]?.children[1]?.id, "L"

Tinytest.add 'independent node list ordering', (test) ->
  nodes = [
    {id: "B", pid: "A"}
    {id: "C", pid: "A"}
    {id: "D", pid: "B"}
    {id: "E", pid: "B"}
    {id: "F", pid: "B"}
    {id: "H", pid: "C"}
    {id: "I", pid: "C"}
    {id: "J", pid: "C"}
    {id: "G", pid: "E"}
    {id: "K", pid: "J"}
    {id: "L", pid: "J"}
  ]
  nodes2 = [
    {id: "H", pid: "C"}
    {id: "I", pid: "C"}
    {id: "J", pid: "C"}
    {id: "D", pid: "B"}
    {id: "C", pid: "A"}
    {id: "E", pid: "B"}
    {id: "F", pid: "B"}
    {id: "G", pid: "E"}
    {id: "K", pid: "J"}
    {id: "L", pid: "J"}
    {id: "B", pid: "A"}
  ]
  

  # tree = treeify {id: "A", children:[]}, nodes
  tree = treeify {
    rootNode: {id: "A", children:[]}
    nodes: nodes
    comparator: cmp
    pidProp: 'pid'
  }
  # tree2 = treeify {id: "A", children:[]}, nodes2
  tree2 = treeify {
    rootNode: {id: "A", children:[]}
    nodes: nodes2
    comparator: cmp
    pidProp: 'pid'
  }

  # // test "tree.root?.id", tree.root?.id, "A"
  test.equal tree.root?.id, tree2.root?.id
  # // test "tree.root?.children?.length", tree.root?.children?.length, 2
  test.equal tree.root?.children?.length, tree2.root?.children?.length
  # # # // test "tree.root?.children[0]?.id", tree.root?.children[0]?.id, "B"
  test.equal tree.root?.children[0]?.id, tree2.root?.children[0]?.id
  # # # // test "tree.root?.children[0]?.children?.length", tree.root?.children[0]?.children?.length, 3
  test.equal tree.root?.children[0]?.children?.length, tree2.root?.children[0]?.children?.length
  # # # // test "tree.root?.children[0]?.children[1]?.children[0]?.id", tree.root?.children[0]?.children[1]?.children[0]?.id, "G"
  test.equal tree.root?.children[0]?.children[1]?.children[0]?.id, tree2.root?.children[0]?.children[1]?.children[0]?.id
  # # # // test "tree.root?.children[1]?.children[2]?.children[1]?.id", tree.root?.children[1]?.children[2]?.children[1]?.id, "L"
  test.equal tree.root?.children[1]?.children[2]?.children[1]?.id, tree2.root?.children[1]?.children[2]?.children[1]?.id
