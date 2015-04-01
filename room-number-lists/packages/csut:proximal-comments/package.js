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

  api.use('csut:ramdajs', ['client', 'server']);
  api.use('reactive-var', ['client', 'server']);
  api.use('csut:js-fsm', ['client', 'server']);
  api.use('coffeescript', ['client', 'server']);
  api.use('templating', ['client']);
  api.use('mongo', ['client', 'server']);

  api.addFiles('both/collections.coffee', ['client', 'server']);
  api.addFiles('client/comment/comment.html', ['client']);
  api.addFiles('client/comment/comment.coffee', ['client']);
  api.addFiles('client/displayChildren/displayChildren.html', ['client']);
  api.addFiles('client/displayChildren/displayChildren.coffee', ['client']);
  api.addFiles('client/proximal_comments/proximal_comments.html', ['client']);
  api.addFiles('client/proximal_comments/proximal_comments.coffee', ['client']);
  api.addFiles('server/dummyData.coffee', ['server']);
  api.addFiles('server/publish.coffee', ['server']);

  api.export('csut_proximalComments_comments');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('csut:proximal-comments');
  api.addFiles('csut:proximal-comments-tests.js');
});
