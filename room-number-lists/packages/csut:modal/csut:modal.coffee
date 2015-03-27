console.log 'model.coffee being called'
Template.csut_modal.helpers {
  'currentWindowHeight': -> "#{$( window ).height()}px"
  'ifThenOr': (ifCond, thenVal, orVal) ->
    isTrue = ifCond is true
    switch
      when thenVal? and isTrue then return thenVal
      when orVal? and not isTrue then return orVal
      else return isTrue
}