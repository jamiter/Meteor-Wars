BlazeLayout.setRoot('body')

Accounts.ui.config
  passwordSignupFields: 'USERNAME_ONLY'

@gridTileSize = 80


Blaze.registerHelper 'equals', (a, b) -> a is b
