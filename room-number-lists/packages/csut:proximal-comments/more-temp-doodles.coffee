window.test = (testName, x, y) =>
  if x isnt y then console.error "#{testName}: expected #{y}, but got #{x}" else console.log "SUCCESS: #{testName}"

# test "tree.root?.id", tree.root?.id, "A"


