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
    parseDrnl: true #dummy true value
  remove:
    parseDrnl: true #dummy true value

class DataListClass
  constructor: (p) ->
    # p = {job: String, run: String, name: String, include: String, remove: String}
    # if the constructor is passed bad parameters, you get back an object that only has an errors field
    
    # make sure only whitelisted fields get propogated
    p = _.pick p, 'job', 'run', 'name', 'include', 'remove'
    
    # validate object
    errors = validate p, DataListConstraints
    
    if errors?
      console.error 'Encountered bad parameters to the DataListClass constructor while trying to construct from:'
      console.error p
      console.log 'errors are:'
      console.error errors
      @errors = errors
    else      
      # copy relevant fields to instance
      @job = p.job
      @run = p.run
      @name = p.name
      @include = p.include
      @remove = p.remove
      @data = lou.sortDataList lou.removeListFromList({include: drnl.parse(p.include), remove: drnl.parse(p.remove)})
      @creationDate = new Date()
      @creatorEmail = Meteor.user().emails[0].address
      @_id = lou.genDataListId p
    
@DataListClass = DataListClass # export to package scope    
    
    