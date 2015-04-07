Package.describe({
  name: 'csut:treeify',
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
  api.use('coffeescript', ['client', 'server']);
  api.use('csut:ramdajs', ['client', 'server']);
  api.addFiles('csut:treeify.coffee');
  api.export('treeify');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('csut:treeify');
  api.use('coffeescript');
  api.addFiles('csut:treeify-tests.coffee');
});
