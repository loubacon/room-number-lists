Meteor.methods({
#     doc._id = id # tack the _id field onto the doc to insert, else mongo makes up an id
#     DataLists.upsert {_id: id}, doc # do an upsert, becaue we assume at this point that overwrites have been confirmed
  'DataLists.insert' : (p) -> 
    list = new RoomNumberListClass p
    console.log list
    unless list.errors? # if there are no errors returned from DataListClass instance construction...
      DataLists.upsert {_id: list._id}, list # do an upsert, becaue we assume at this point that overwrites have been confirmed
  'DataLists.update' : (o) -> DataLists.update o._id, addCreationInfo(o)
  'DataLists.remove' : (id) -> DataLists.remove id
})