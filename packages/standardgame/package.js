Package.describe({
  name: 'meteorwars:standardgame',
  version: '0.0.1',
  summary: 'Adds a standard 1 vs 1 game to Meteor Wars',
  git: '',
  documentation: 'README.md'
});

var unitFiles = [
  'units/UnitRifleman.html',
  'units/UnitTank.html',
  'units/UnitBazooka.html',
];

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.2');
  api.use('ecmascript');
  api.use('blaze-html-templates');

  api.addFiles(unitFiles, 'client');

  api.addFiles('standardgame.js', 'server');
});
