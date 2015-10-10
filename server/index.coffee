Meteor.startup ->
  unitTypeCount = UnitTypes.find().count()

  console.log "#{unitTypeCount} unit types"
