# define a app-wide reference to this collection using @
@DataLists = new Mongo.Collection('DataLists')

if Meteor.isServer
  Meteor.publish 'DataLists', (job) -> 
    # Meteor._sleepForMs 3000
    DataLists.find {job: job}
