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

    selectedMap = this
    Rounds.update({_id: roundId}, {$set: {selectedMap: selectedMap.name, mapMatrix: selectedMap.mapMatrix}})
    round = Rounds.findOne(_id: roundId)

    selectedMap.objectMapping.forEach (unitObject) ->
      unit =
        x: unitObject.x
        y: unitObject.y
        angle: unitObject.angle
        playerIndex: unitObject.playerIndex

      for attr of unitObject.unitObjectType
        if attr is 'maxHealth'
          unit.health = unitObject.unitObjectType[attr]

        unit[attr] = unitObject.unitObjectType[attr]

      round.addUnit unit

    round.start()

    FlowRouter.go "/games/#{round.gameId}/rounds/#{round._id}/play"

  'click .go-to-game': (event) ->
    FlowRouter.go "/games/#{@gameId}/rounds/#{@_id}/play"
