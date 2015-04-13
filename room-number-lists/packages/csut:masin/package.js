Package.describe({
  name: 'csut:masin',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: ' A reactive state mutation tool',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.4.2');
  api.addFiles('masin.coffee');
  api.use('csut:ramdajs');
  api.use('coffeescript')
  api.export('Masin');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('csut:masin');
  api.use('coffeescript')
  api.addFiles('masin-tests.coffee');
});
