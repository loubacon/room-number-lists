Package.describe({
  name: 'csut:einfach',
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
  api.addFiles('einfach.coffee');
  api.use('csut:ramdajs');
  api.use('reactive-var', ['client']);
  api.use('coffeescript');
  api.use('csut:validate');
  api.export('Einfach');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('csut:einfach');
  api.use('coffeescript');
  api.addFiles('einfach-tests.coffee');
});
