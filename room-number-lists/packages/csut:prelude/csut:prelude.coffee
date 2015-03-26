csut = {}

csut.objectifyForm = (form) ->
  # convert a form from the DOM to an object where each key is the name of an input element
  # and each value is the corresponding value of that input element at the time of collection
  f = (o) ->
    o2 = {}
    o2[o.name] = o.value
    return o2
  
  formArray = R.map f, form.serializeArray()
  
  formObj = R.reduce R.merge, {}, formArray
  
  return formObj

@csut = csut