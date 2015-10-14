@Turns = new Mongo.Collection 'turns',
  transform: (data) ->
    new Turn data

class Turn extends Model

  @_collection: Turns

  start: ->
    @update $set: startedAt: new Date

  finish: ->
    Units.update
      playerId: @playerId
    ,
      $unset:
        moved: 1
        attacked: 1
    ,
      multi: true

    @update $set: finishedAt: new Date

  findPlayer: ->
    Players.findOne @playerId
