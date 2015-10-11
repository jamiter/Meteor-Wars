Meteor.publish 'games', (query = {}) ->
  Games.find query

Meteor.publish 'rounds', (query = {}) ->
  Rounds.find query

Meteor.publish 'players', (query = {}) ->
  Players.find query

Meteor.publish 'turns', (query = {}) ->
  Turns.find query

Meteor.publish 'units', (query = {}) ->
  Units.find query

Meteor.publish 'immutables', (query = {}) ->
  Immutables.find query
