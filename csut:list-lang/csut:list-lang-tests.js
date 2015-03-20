Tinytest.add('input_1', function (test) {
  var input = '101';
  var expectedOutput = ['101'];
  var actualOutput = listLang.parse(input);
  test.equal(expectedOutput, actualOutput);
});

Tinytest.add('input_2', function (test) {
  var input = '101-103';
  var expectedOutput = ['101', '102', '103'];
  var actualOutput = listLang.parse(input);
  test.equal(expectedOutput, actualOutput);
});

Tinytest.add('input_3', function (test) {
  var input = '101-103*2';
  var expectedOutput = ['101', '102', '103', '101', '102', '103'];
  var actualOutput = listLang.parse(input);
  test.equal(expectedOutput, actualOutput);
});

Tinytest.add('input_4', function (test) {
  var input = '/yippy yip';
  var expectedOutput = ['yippy yip'];
  var actualOutput = listLang.parse(input);
  test.equal(expectedOutput, actualOutput);
});

Tinytest.add('input_5', function (test) {
  var input = '/yippy yip*4, 120-121*2, /hiya';
  var expectedOutput = ['yippy yip', 'yippy yip', 'yippy yip', 'yippy yip', '120', '121', '120', '121', 'hiya'];
  var actualOutput = listLang.parse(input);
  test.equal(expectedOutput, actualOutput);
});

Tinytest.add('error_1', function (test) {
  var input = 'wtf';
  try {
    listLang.parse(input);
  } catch (err) {
    test.equal(err.message, 'Expected "/", [0-9] or end of input but "w" found.');
  }
});

Tinytest.add('error_2', function (test) {
  var input = '!';
  try {
    listLang.parse(input);
  } catch (err) {
    test.equal(err.message, 'Expected "/", [0-9] or end of input but "!" found.');
  }
});
