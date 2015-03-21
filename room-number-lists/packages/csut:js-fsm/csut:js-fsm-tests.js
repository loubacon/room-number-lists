// Write your tests here!
// Here is an example.

Tinytest.add('fsm_1', function (test) {
  var fsm = StateMachine.create({
    initial: 'green',
    events: [
      { name: 'warn',  from: 'green',  to: 'yellow' },
      { name: 'panic', from: 'yellow', to: 'red'    },
      { name: 'calm',  from: 'red',    to: 'yellow' },
      { name: 'clear', from: 'yellow', to: 'green'  }
  ]});
  test.equal(fsm.current, 'green');
});

Tinytest.add('fsm_2', function (test) {
  var fsm = StateMachine.create({
    initial: 'green',
    events: [
      { name: 'warn',  from: 'green',  to: 'yellow' },
      { name: 'panic', from: 'yellow', to: 'red'    },
      { name: 'calm',  from: 'red',    to: 'yellow' },
      { name: 'clear', from: 'yellow', to: 'green'  }
  ]});
  fsm.warn();
  test.equal(fsm.current, 'yellow');
});

Tinytest.add('fsm_3', function (test) {
  var fsm = StateMachine.create({
    initial: 'green',
    events: [
      { name: 'warn',  from: 'green',  to: 'yellow' },
      { name: 'panic', from: 'yellow', to: 'red'    },
      { name: 'calm',  from: 'red',    to: 'yellow' },
      { name: 'clear', from: 'yellow', to: 'green'  }
  ]});
  fsm.warn();
  fsm.panic();
  test.equal(fsm.current, 'red');
});
Tinytest.add('fsm_4', function (test) {
  var fsm = StateMachine.create({
    initial: 'green',
    events: [
      { name: 'warn',  from: 'green',  to: 'yellow' },
      { name: 'panic', from: 'yellow', to: 'red'    },
      { name: 'calm',  from: 'red',    to: 'yellow' },
      { name: 'clear', from: 'yellow', to: 'green'  }
  ]});
  fsm.warn();
  fsm.panic();
  fsm.calm();
  test.equal(fsm.current, 'yellow');
});

Tinytest.add('fsm_5', function (test) {
  var fsm = StateMachine.create({
    initial: 'green',
    events: [
      { name: 'warn',  from: 'green',  to: 'yellow' },
      { name: 'panic', from: 'yellow', to: 'red'    },
      { name: 'calm',  from: 'red',    to: 'yellow' },
      { name: 'clear', from: 'yellow', to: 'green'  }
  ]});
  fsm.warn();
  fsm.panic();
  fsm.calm();
  fsm.clear();
  test.equal(fsm.current, 'green');
});

Tinytest.add('fsm_6', function (test) {
  var fsm = StateMachine.create({
    initial: 'green',
    events: [
      { name: 'warn',  from: 'green',  to: 'yellow' },
      { name: 'panic', from: 'yellow', to: 'red'    },
      { name: 'calm',  from: 'red',    to: 'yellow' },
      { name: 'clear', from: 'yellow', to: 'green'  }
  ]});
  fsm.warn();
  fsm.clear();
  test.equal(fsm.current, 'green');
});