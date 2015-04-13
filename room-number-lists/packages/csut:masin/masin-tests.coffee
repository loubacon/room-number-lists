Tinytest.add 'Tinytest mic check', (test) ->
  test.equal true, true

if Meteor.isClient
  Tinytest.add 'Masin 1', (test) ->
    m1 = Masin {x : 5}
    test.equal m1.current('x'), 5

  Tinytest.add 'Masin 2', (test) ->
    x = Masin {}
    test.equal x.has('y'), false
    test.equal x.current('y'), undefined
    x.to {y: 0}
    test.equal x.has('y'), true
    test.equal x.current('y'), 0
    z = Masin {'yoyo': 900}
    test.equal z.current('yoyo'), 900
    test.equal x.current('yoyo'), undefined
    x.to {'yoyo': z.current('yoyo')}
    z.to {}
    test.equal z.has('yoyo'), false
    test.equal x.has('yoyo'), true
    test.equal x.current('yoyo'), 900
