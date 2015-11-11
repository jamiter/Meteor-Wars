Package.describe({
  name: 'meteorwars:standardgame',
  version: '0.0.1',
  summary: 'Adds a standard 1 vs 1 game to Meteor Wars',
  git: '',
  documentation: 'README.md'
});

var objectFiles = [
    'objects/ObjectForest.html',
    'terrains/TerrainMountain.html',
    'terrains/TerrainRiver.html',
    'terrains/TerrainRiverH.html',
    'terrains/TerrainBridge.html',
    'terrains/TerrainRoadH.html',
    'terrains/TerrainRoadV.html'
];

var unitFiles = [
    'units/UnitJeep.html',
    'units/UnitRifleman.html',
    'units/UnitTank.html',
    'units/UnitBazooka.html'
];

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.2');
  api.use('ecmascript');
  api.use('blaze-html-templates');

  api.addFiles(objectFiles, 'client');
  api.addFiles(unitFiles, 'client');

  api.addFiles('standardgame.js', 'server');
});
