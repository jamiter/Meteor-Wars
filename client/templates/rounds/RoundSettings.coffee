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

    selectedMap.objectMapping.forEach (object) ->
      unit =
        x: object.x
        y: object.y
        angle: object.angle
        playerIndex: object.playerIndex
      if object.unitObjectType
        for attr of object.unitObjectType
          if attr is 'maxHealth'
            unit.health = object.unitObjectType[attr]

          unit[attr] = object.unitObjectType[attr]

        round.addUnit unit
      if object.immutableObjectType
        for attr of object.immutableObjectType
          unit[attr] = object.immutableObjectType[attr]

        delete unit.playerIndex
        unit['roundId'] = roundId
        Immutables.insert unit

    round.start()

    FlowRouter.go "/games/#{round.gameId}/rounds/#{round._id}/play"

  'click .go-to-game': (event) ->
    FlowRouter.go "/games/#{@gameId}/rounds/#{@_id}/play"
