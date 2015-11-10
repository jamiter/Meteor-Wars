Meteor.startup(function () {
    var unitType =
    {
        rifleman: {
            name: "G.I. Jane",
            type: "infantry",
            templateName: "UnitRifleman",
            maxHealth: 100,
            minShootingrange: 0,
            maxShootingrange: 1,
            moverange: 3,
            moveType: 'foot',
            cost: 1000,
            damage: {
                infantry: 60,
                armor: 10,
                air: 0
            }
        },
        tank: {
            name: "M1 Abrams",
            type: "armor",
            templateName: "UnitTank",
            maxHealth: 250,
            minShootingrange: 0,
            maxShootingrange: 5,
            moverange: 6,
            moveType: 'threads',
            cost: 7000,
            damage: {
                infantry: 70,
                armor: 80,
                air: 0
            }
        },
        bazooka: {
            name: "Bazooka Bill",
            type: "infantry",
            templateName: "UnitBazooka",
            maxHealth: 100,
            minShootingrange: 0,
            maxShootingrange: 3,
            moverange: 2,
            moveType: 'mech',
            cost: 3000,
            damage: {
                infantry: 20,
                armor: 100,
                air: 50
            }
        },
        jeep: {
            name: "Meep Jeep",
            type: "armor",
            templateName: "UnitJeep",
            maxHealth: 150,
            minShootingrange: 0,
            maxShootingrange: 2,
            moverange: 8,
            moveType: 'wheels',
            cost: 4000,
            damage: {
                infantry: 80,
                armor: 20,
                air: 20
            }
        }
    };
    var terrainType = {
        tree: {
            name: "Bonsai Tree",
            templateName: "ObjectForest",
            defence: 3,
            moveCost: {
                foot: 1,
                mech: 1,
                wheels: 2,
                threads: 3,
                air: 1
            }
        },
        mountain: {
            name: "Himalaya",
            templateName: "TerrainMountain",
            defence: 4,
            moveCost: {
                foot: 2,
                mech: 1,
                air: 1
            }
        },
        river: {
            name: "Mississippi",
            templateName: "TerrainRiver",
            defence: 0,
            moveCost: {
                foot: 2,
                mech: 1,
                air: 1
            }
        },
        bridge: {
            name: "Bridge",
            templateName: "TerrainBridge",
            defence: 0,
            moveCost: {
                foot: 1,
                mech: 1,
                wheels: 1,
                threads: 1,
                air: 1
            }
        }
        ,
        roadH: {
            name: "Road Horizontal",
            templateName: "TerrainRoadH",
            defence: 0,
            moveCost: {
                foot: 1,
                mech: 1,
                wheels: 1,
                threads: 1,
                air: 1
            }
        }
    };
    var maps = [
        {
            name: "Rough Neighbourhood",
            dimensions: [5, 5],
            minPlayers: 2,
            maxPlayers: 2,
            objectMapping: [
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 1,
                    loc: [2, 1],
                    angle: 0
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 1,
                    loc: [4, 3],
                    angle: 180
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 1,
                    loc: [4, 2],
                    angle: 180
                },
                {
                    terrainType: terrainType.city,
                    loc: [4, 1],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [0, 3],
                    angle: 0
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 0,
                    loc: [2, 4],
                    angle: 180
                }]
        },
        {
            name: "World War Z",
            dimensions: [22, 12],
            minPlayers: 2,
            maxPlayers: 2,
            objectMapping: [
                {
                    unitTypeId: 'jeep',
                    playerIndex: 0,
                    loc: [6, 10],
                    angle: 0
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 0,
                    loc: [8, 11],
                    angle: 0
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 0,
                    loc: [9, 4],
                    angle: 0
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 0,
                    loc: [2, 4],
                    angle: 0
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 1,
                    loc: [11, 6],
                    angle: 180
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 1,
                    loc: [16, 7],
                    angle: 180
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 1,
                    loc: [18, 3],
                    angle: 180
                },
                {
                    unitTypeId: 'jeep',
                    playerIndex: 1,
                    loc: [17, 2],
                    angle: 180
                },
                {
                    terrainType: terrainType.city,
                    loc: [7, 6],
                    angle: 180
                },
                {
                    terrainType: terrainType.city,
                    loc: [9, 3],
                    angle: 180
                },
                {
                    terrainType: terrainType.city,
                    loc: [12, 9],
                    angle: 0
                },
                {
                    terrainType: terrainType.city,
                    loc: [9, 9],
                    angle: 180
                },
                {
                    terrainType: terrainType.city,
                    loc: [13, 4],
                    angle: 180
                },
                {
                    terrainType: terrainType.city,
                    loc: [11, 7],
                    angle: 0
                },
                {
                    terrainType: terrainType.city,
                    loc: [11, 8],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [8, 4],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [18, 8],
                    angle: 0
                },
                {
                    terrainType: terrainType.tree,
                    loc: [3, 6],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [14, 4],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [19, 8],
                    angle: 0
                },
                {
                    terrainType: terrainType.tree,
                    loc: [6, 0],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [9, 5],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [5, 8],
                    angle: 0
                },
                {
                    terrainType: terrainType.tree,
                    loc: [18, 5],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [19, 9],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [17, 7],
                    angle: 180
                },
                {
                    terrainType: terrainType.tree,
                    loc: [13, 9],
                    angle: 0
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 0,
                    loc: [4, 3],
                    angle: 0
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 0,
                    loc: [5, 6],
                    angle: 0
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 0,
                    loc: [8, 7],
                    angle: 0
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 0,
                    loc: [3, 2],
                    angle: 0
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 0,
                    loc: [7, 3],
                    angle: 0
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 0,
                    loc: [8, 5],
                    angle: 0
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 1,
                    loc: [11, 7],
                    angle: 180
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 1,
                    loc: [17, 5],
                    angle: 180
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 1,
                    loc: [13, 4],
                    angle: 180
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 1,
                    loc: [19, 5],
                    angle: 180
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 1,
                    loc: [16, 2],
                    angle: 180
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 1,
                    loc: [14, 6],
                    angle: 180
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 0,
                    loc: [2, 1],
                    angle: 0
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 0,
                    loc: [3, 3],
                    angle: 0
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 0,
                    loc: [6, 7],
                    angle: 0
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 0,
                    loc: [9, 4],
                    angle: 0
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 0,
                    loc: [4, 3],
                    angle: 0
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 0,
                    loc: [1, 6],
                    angle: 0
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 1,
                    loc: [13, 3],
                    angle: 180
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 1,
                    loc: [18, 0],
                    angle: 180
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 1,
                    loc: [16, 4],
                    angle: 180
                },
                {
                    unitTypeId: 'rifleman',
                    playerIndex: 1,
                    loc: [11, 5],
                    angle: 180
                },
                {
                    unitTypeId: 'tank',
                    playerIndex: 1,
                    loc: [13, 2],
                    angle: 180
                },
                {
                    unitTypeId: 'bazooka',
                    playerIndex: 1,
                    loc: [17, 6],
                    angle: 180
                }]
        }
    ];

    var gameId = null;
    var gameData = {
        name: "Standard 1 vs 1 Game"
    };
    var game = Games.findOne({name: gameData.name});

    if (!game) {
        gameId = Games.insert(gameData);
    } else {
        gameId = game._id
    }

    //var unitTypesAreLoaded = !!UnitTypes.findOne({gameId: gameId});

    _.each(unitType, function(details, _id) {
        var data = {
            gameId: gameId
        };

        var typeData = _.extend(data, details);

        UnitTypes.upsert({_id: _id}, {$set: typeData});
    });

    //var terrainTypesAreLoaded = !!TerrainTypes.findOne({gameId: gameId});

    _.each(terrainType, function(details, _id) {
        var data = {
            gameId: gameId,
        };

        var typeData = _.extend(data, details);

        TerrainTypes.upsert({_id: _id}, {$set: typeData});
    });

    var mapsAreLoaded = !!GameMaps.findOne({gameId: gameId});

    if (!mapsAreLoaded) {
        maps.forEach(function(map) {
            map.gameId = gameId;
            units = map.objectMapping;

            delete map.objectMapping;

            var mapId = GameMaps.insert(map);

            var defaultUnitData = {
                gameId: gameId,
                gameMapId: mapId
            };

            units.forEach(function(unitData) {
                if (unitData.unitTypeId) {
                    typeData = unitType[unitData.unitTypeId];

                    data = _.extend({},
                        defaultUnitData,
                        unitData,
                        typeData
                    );

                    GameMapUnits.insert(data);
                }
                //else if (unitData.terrainType) {
                //    typeData = unitType[unitData.terrainType];
                //
                //    data = _.extend({},
                //        defaultUnitData,
                //        unitData,
                //        typeData
                //    );
                //
                //    GameMapTerrains.insert(data);
                //}
            })
        });
    };
});
