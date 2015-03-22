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
    include: '141-150',
    remove: '145-149',
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  test.equal(l.job, '12345');
  test.equal(l.run, 'A');
  test.equal(l.name, '#s');
  test.equal(l.include, '141-150');
  test.equal(l.remove, '145-149');
  test.equal(l.creatorEmail, 'test@test.com');
  test.equal(l.creationDate, 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)');
  test.equal(l.list, ['141', '142', '143', '144', '150']);
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

Tinytest.add('room-number-list-class_error_1', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '1234',
    run: 'A',
    name: '#s',
    include: "1-3*3, /yo*2",
    remove: "1-3*2, /yo*1",
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  console.log(l);
  test.equal(l, {
    errors: {
      job: ['Job must be a valid job number']
    }
  });
});
Tinytest.add('room-number-list-class_error_2', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '1234',
    run: '',
    name: '#s',
    include: "1-3*3, /yo*2",
    remove: "1-3*2, /yo*1",
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  console.log(l);
  test.equal(l, {
    errors: {
      job: ['Job must be a valid job number'],
      run: ['Run can\'t be blank']
    }
  });
});
Tinytest.add('room-number-list-class_error_3', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '1234',
    run: 'a',
    name: '#s',
    include: "1-3*3, /yo*2",
    remove: "1-3*2, /yo*1",
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  console.log(l);
  test.equal(l, {
    errors: {
      job: ['Job must be a valid job number'],
      run: ['Run must be a single capital letter']
    }
  });
});
Tinytest.add('room-number-list-class_error_4', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '1234',
    run: 'a',
    name: '',
    include: "1-3*3, /yo*2",
    remove: "1-3*2, /yo*1",
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  console.log(l);
  test.equal(l, {
    errors: {
      job: ['Job must be a valid job number'],
      run: ['Run must be a single capital letter'],
      name: ['Name can\'t be blank']
    }
  });
});
Tinytest.add('room-number-list-class_error_5', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '1234',
    run: 'a',
    name: '',
    include: "",
    remove: "1-3*2, /yo*1",
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  console.log(l);
  test.equal(l, {
    errors: {
      job: ['Job must be a valid job number'],
      run: ['Run must be a single capital letter'],
      name: ['Name can\'t be blank'],
      include: ["Include can't be blank"]
    }
  });
});
Tinytest.add('room-number-list-class_error_6', function (test) {
  // Meteor.loginWithPassword('test@test.com', 'password');
  var l = new RoomNumberListClass({
    job: '1234',
    run: 'a',
    name: '',
    include: "",
    remove: "",
    creatorEmail: "test@test.com",
    creationDate: 'Sat Mar 21 2015 10:14:59 GMT-0700 (PDT)'
  });
  console.log(l);
  test.equal(l, {
    errors: {
      job: ['Job must be a valid job number'],
      run: ['Run must be a single capital letter'],
      name: ['Name can\'t be blank'],
      include: ["Include can't be blank"]
    }
  });
});

