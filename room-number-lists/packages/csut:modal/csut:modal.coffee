Template.csut_modal.helpers {
  'currentWindowHeight': -> "#{$( window ).height()}px"
  'ifThenOr': (ifCond, thenVal, orVal) ->
    isTrue = ifCond is true
    switch
      when thenVal? and isTrue then return thenVal
      when orVal? and not isTrue then return orVal
      else return isTrue
}
csut_modal = {}

csut_modal.eventWasOutsideOf = (e, sel) ->
  xs = $( e.target ).closest( sel ) # array of elements in e.target's dom acestry that match sel
  return xs.length < 1 # boolean result, true if the event target has no ancestors matching sel

@csut_modal = csut_modal