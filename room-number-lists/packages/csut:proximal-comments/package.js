Package.describe({
  name: 'csut:proximal-comments',
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
  api.use('ddp', ['client', 'server']);
  api.use('coffeescript', ['client', 'server']);
  api.use('templating', ['client']);
  api.use('mongo', ['client', 'server']);
  api.use('mongo-livedata', ['client', 'server']);
  // api.use('mongo-platform', ['client', 'server']);
  api.use('tracker', ['client', 'server']);
  api.use('deps', ['client', 'server']);
  api.use('ddp', ['client', 'server']);
  api.addFiles(['csut:proximal-comments.html', 'csut:proximal-comments.coffee']);
  api.export('csut_proximalComments_comments');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('csut:proximal-comments');
  api.addFiles('csut:proximal-comments-tests.js');
});
