Template.GameMapCreateForm.events
  'click .create-map': (event) ->
    event.preventDefault()

    name = prompt("Please enter a name for the map", "My awesome map")

    return unless name

    gameId = FlowRouter.getParam 'gameId'

    mapId = GameMaps.insert
      createdBy: Meteor.userId()
      gameId: gameId
      dimensions: [7,5]
      name: name
      minPlayers: 2
      maxPlayers: 2

    FlowRouter.go "/games/#{gameId}/maps/#{mapId}"
