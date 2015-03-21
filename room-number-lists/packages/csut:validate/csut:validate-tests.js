var constraints = {
  creditCardNumber: {
    presence: true,
    format: {
      pattern: /^(34|37|4|5[1-5]).*$/,
      message: "must be a valid Amex, Visa or Mastercard number"
    },
    length: function(value, attributes, attributeName, options, constraints) {
      if (value) {
        // Amex
        if ((/^(34|37).*$/).test(value)) return {is: 15};
        // Visa, Mastercard
        if ((/^(4|5[1-5]).*$/).test(value)) return {is: 16};
      }
      // Unknown card, don't validate length
      return false;
    }
  },
  creditCardZip: function(value, attributes, attributeName, options, constraints) {
    if (!(/^(34|37).*$/).test(attributes.creditCardNumber)) return null;
    return {
      presence: true,
      length: {is: 5}
    };
  }
};

Tinytest.add('validationExample_1', function (test) {
  var results = validate({creditCardNumber: "4"}, constraints);
  var errors = {"creditCardNumber": ["Credit card number is the wrong length (should be 16 characters)"]};
  test.equal(results, errors);
});

Tinytest.add('validationExample_2', function (test) {
  var results = validate({creditCardNumber: "4"}, constraints);
  var errors = {"creditCardNumber": ["Credit card number is the wrong length (should be 16 characters)"]};
  test.equal(results, errors);
});

Tinytest.add('validationExample_3', function (test) {
  var results = validate({creditCardNumber: "4242424242424242"}, constraints);
  var errors = undefined;
  test.equal(results, errors);
});

Tinytest.add('validationExample_4', function (test) {
  var results = validate({creditCardNumber: "340000000000000"}, constraints);
  var errors = {"creditCardZip": ["Credit card zip can't be blank"]};
  test.equal(results, errors);
});