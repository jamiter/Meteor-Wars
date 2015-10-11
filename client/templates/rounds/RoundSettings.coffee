Template.RoundSettings.helpers
  map: ->
    gameId = FlowRouter.getParam 'gameId'

    Games.findOne(_id: gameId).maps

  round: ->
    roundId = FlowRouter.getParam 'roundId'

    Rounds.findOne _id: roundId

  hostName: ->
    Players.findOne(userId: @createdBy)?.name or 'the host'

  canJoin: ->
    @canJoin Meteor.userId()

  canStart: ->
    @canStart Meteor.userId()

Template.RoundSettings.events
  'click .join-game': (event) ->
    @addPlayer userId: Meteor.userId()

  'click .leave-game': (event) ->


  'click .start-game': (event) ->
    roundId = FlowRouter.getParam 'roundId'
    console.log this
    selectedMap = this
    Rounds.update({_id: roundId}, {$set: {selectedMap: selectedMap.name, mapMatrix: selectedMap.mapMatrix}})
    round = Rounds.findOne(_id: roundId)
    console.log round
    i = 0
    while i < selectedMap.objectMapping.length
      unitObject = selectedMap.objectMapping[i]
      unit = {roundId: round._id, mapMatrixPosition: unitObject.position}
      for attr of unitObject.unitObjectType
        unit[attr] = unitObject.unitObjectType[attr]
      Units.insert(unit);
      i++

    round.start()

    FlowRouter.go "/games/#{round.gameId}/rounds/#{round._id}/play"

  'click .go-to-game': (event) ->
    FlowRouter.go "/games/#{@gameId}/rounds/#{@_id}/play"

