Package.describe({
  name: 'csut:blueprint',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.4.2');
  api.addFiles(['csut:blueprint.html', 'csut:blueprint.css', 'csut:blueprint.coffee']);
  api.use(['coffeescript', 'csut:prelude', 'templating', 'csut:js-fsm']);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('csut:blueprint');
  api.addFiles('csut:blueprint-tests.js');
});
