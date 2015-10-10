Package.describe({
  name: 'pathfinding',
  version: '0.4.17'
});

Npm.depends({
  pathfinding: "0.4.17"
});

Package.onUse(function (api) {
  api.addFiles('./.npm/package/node_modules/pathfinding/visual/lib/pathfinding-browser.min.js', ['client']);
  api.addFiles('./pathfinding.js', ['server']);
  api.export('pathfinding', ['server', 'client']);
});
