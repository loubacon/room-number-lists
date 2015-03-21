// Write your tests here!
// Here is an example.
// # p = {job: String, run: String, name: String, include: String, remove: String}
//     # if the constructor is passed bad parameters, you get back an object that only has an errors field

Tinytest.add('room-number-list-class_1', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '12345',
    run: 'A',
    name: '#s',
    include: '101-150',
    remove: '145-149',
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  test.equal(l.job, '12345');
});

Tinytest.add('room-number-list-class_2', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '12345',
    run: 'A',
    name: '#s',
    include: '101-105',
    remove: '',
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  test.equal(l.list, ['101', '102', '103', '104', '105']);
});

Tinytest.add('room-number-list-class_3', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '12345',
    run: 'A',
    name: '#s',
    include: '101-105',
    remove: '0-104',
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  test.equal(l.list, ['105']);
});

Tinytest.add('room-number-list-class_4', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '12345',
    run: 'A',
    name: '#s',
    include: '105*3',
    remove: '105',
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  test.equal(l.list, ['105', '105']);
});

Tinytest.add('room-number-list-class_5', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '12345',
    run: 'A',
    name: '#s',
    include: "1-3*3, /yo*2",
    remove: "1-3*2, /yo*1",
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  test.equal(l.list, ['1', '2', '3', 'yo']);
});
