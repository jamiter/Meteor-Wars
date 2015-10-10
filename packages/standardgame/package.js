Package.describe({
  name: 'meteorwars:standardgame',
  version: '0.0.1',
  summary: 'Adds a standard 1 vs 1 game to Meteor Wars',
  git: '',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.2');
  api.use('ecmascript');
  api.addFiles('standardgame.js', 'server');
});

