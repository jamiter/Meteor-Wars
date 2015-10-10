@Turns = new Mongo.Collection 'turns',
  transform: (data) ->
    new Turn data

class Turn extends Model

  @_collection: Turns

  start: ->
    @update $set: startedAt: new Date

    player = @findPlayer()

    if player?.isAi()
      player.aiPlay()

  finish: ->
    @update $set: finishedAt: new Date

  findPlayer: ->
    Players.findOne @playerId
