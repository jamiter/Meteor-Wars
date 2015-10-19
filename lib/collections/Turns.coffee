@Turns = new Mongo.Collection 'turns',
  transform: (data) ->
    new Turn data

TurnSchema = new SimpleSchema
  gameId:
    type: String
  roundId:
    type: String
    index: 1
  playerId:
    type: String
  startedAt:
    type: Date
  finishedAt:
    type: Date
    optional: true

Turns.attachSchema TurnSchema

class Turn extends Model

  @_collection: Turns

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
