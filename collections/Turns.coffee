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
    Units.update
      playerId: @playerId
    ,
      $unset:
        hasMoved: 1
        hasAttacked: 1
    ,
      multi: true

    @update $set: finishedAt: new Date

  findPlayer: ->
    Players.findOne @playerId
