Package.describe({
  name: 'tinycolor2',
  version: '1.1.2'
});

Npm.depends({
  tinycolor2: "1.1.2"
});

Package.onUse(function (api) {
  api.addFiles('./.npm/package/node_modules/tinycolor2/tinycolor.js', ['client']);
});
