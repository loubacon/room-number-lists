validate.validators.parsesAsValidListLang = (value, options, key, attr) ->
  try
    listLang.parse value
  catch error
    return error.message
  return # if no error is thrown by the parser, make sure to return nothing, else the call to parse above will return the parser's output!

sortDataList = (xs) ->  _.sortBy xs, _s.naturalCmp

genDataListId = (p) ->
  [p.job, p.run, p.name].join('-')

removeListFromList = (p) ->
  # p = {superList: [], subList: []}
  # iterate through each value in subList, and remove that value once from superList

  # console.log p
  # # can't use sets for this, as duplicates must be allowed
  ###
  RESUME HERE
  make a "remove from array" function that take an index and returns an array with the item at that index removed
  then 
  ###
  removeFromInc = (x) ->
    i = R.findIndex R.eq(x), p.include # i will be -1 if x is not found in inc
    if i >= 0 then p.include.splice i, 1 # if we found x in inc, remove it!

  R.forEach removeFromInc, p.remove # subtract one instance of each item in rem, from inc (mutate in place, ooh very bad)

  return p.include

DataListConstraints =
  job: 
    presence: true
    format: 
      pattern: /^\d{5}$/
      message: 'must be a valid job number'
  run: 
    presence: true
    format: 
      pattern: /^[A-Z]$/
      message: 'must be a single capital letter'
  name: 
    presence: true
    # removed uniqueListName from constraints, as this code only runs on server
    # and by this point we have confirmed overrides in client
    # and a call to confirm on the server will throw an error (node has no confirm global method)
    # and uniqueListName has to have the user confirm overwrites
#     uniqueListName: true # including teh uniqueListName key in this object runs its function, passing true is a red herring
    format: 
      pattern: /^.+$/
      message: 'must be present'
  include: 
    presence: true
    parsesAsValidListLang: true #dummy true value
  remove:
    parsesAsValidListLang: true #dummy true value
  creatorEmail:
    email: true 
    presence: true
  creationDate:
    datetime: true
    presence: true

class RoomNumberListClass
  constructor: (p) ->
    # p = {job: String, run: String, name: String, include: String, remove: String, creatorEmail: 'String', creationDate: 'String'}
    # if the constructor is passed bad parameters, you get back an object that only has an errors field
    
    # make sure only whitelisted fields get propogated
    p = _.pick p, 'job', 'run', 'name', 'include', 'remove', 'creatorEmail', 'creationDate'
    
    # validate object
    errors = validate p, DataListConstraints
    
    if errors?
      console.error 'Encountered bad parameters to the RoomNumberListClass constructor while trying to construct from:'
      console.error p
      console.log 'errors are:'
      console.error _.values(errors).join(' | ')
      @errors = errors
    else      
      # copy relevant fields to instance
      @job = p.job
      @run = p.run
      @name = p.name
      @include = p.include
      @remove = p.remove
      @list = sortDataList removeListFromList({include: listLang.parse(p.include), remove: listLang.parse(p.remove)})
      @creationDate = p.creationDate
      @creatorEmail = p.creatorEmail
      @_id = genDataListId p
    
@RoomNumberListClass = RoomNumberListClass # export to package scope    
    
    