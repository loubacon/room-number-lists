Package.describe({
  name: 'csut:room-number-list-class',
  version: '0.0.7',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.3.1');
  api.use(['coffeescript', 'csut:validate', 'accounts-base', 'accounts-password', 'csut:list-lang', 'underscore', 'wizonesolutions:underscore-string', 'mrt:moment', 'csut:ramdajs']);
  api.addFiles('csut:room-number-list-class.coffee');
  api.export(['RoomNumberListClass', 'RoomNumberListClassMethods']);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('csut:room-number-list-class');
  api.addFiles('csut:room-number-list-class-tests.js');
});
