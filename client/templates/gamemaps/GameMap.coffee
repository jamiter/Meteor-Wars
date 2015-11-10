Template.GameMap.onRendered ->
  map = @data

  @$(".tile").droppable
    accept: ".unit, .unit-type"
    activeClass: "reachable"
    hoverClass: "path"
    drop: ( event, ui ) ->
      tile = Blaze.getData(this)
      location = [tile.x, tile.y]

      item = Blaze.getData(ui.draggable[0])

      if item.unit instanceof GameMapUnit
        if item.unit.loc.toString() isnt location.toString()
          GameMapUnits.findOne(loc: location)?.remove()
          item.unit.set(loc: location)
          true
        else
          false
      else if item instanceof GameMapTerrain
        GameMapTerrains.findOne(loc: location)?.remove()

        item.set(loc: location)
        true
      else if item instanceof UnitType
        playerIndex = FlowRouter.getQueryParam('playerIndex')

        return unless playerIndex

        GameMapUnits.findOne(loc: location)?.remove()

        playerIndex = parseInt playerIndex, 10

        data =
          gameId: map.gameId
          gameMapId: map._id
          unitTypeId: item._id
          playerIndex: playerIndex
          loc: location
          angle: playerIndex * 90

        allData = _.extend {}, item, data
        delete allData._id

        GameMapUnits.insert allData

        true
      else if item instanceof TerrainType
        GameMapTerrains.findOne(loc: location)?.remove()

        data =
          gameId: map.gameId
          gameMapId: map._id
          terrainTypeId: item._id
          loc: location
          angle: 0

        allData = _.extend {}, item, data
        delete allData._id

        GameMapTerrains.insert allData

Template.GameMap.helpers
  mapStyle: ->
    grid = @getGrid()

    "width: #{grid.width * gridTileSize}px;
    height: #{grid.height * gridTileSize}px"

  tiles: ->
    @getGrid().nodes
