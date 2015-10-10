Template.GameCreateForm.events
  'click .create-game': (event) ->
    event.preventDefault()

    name = Meteor.user()?.emails?[0].address + ' game'

    console.log "creating #{name}"

    Games.insert name: name
