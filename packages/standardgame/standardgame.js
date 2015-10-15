Meteor.startup(function () {
    var unitObjectType =
    {
        rifleman: {
            name: "G.I. Jane",
            type: "infantry",
            templateName: "UnitRifleman",
            maxHealth: 100,
            minShootingrange: 0,
            maxShootingrange: 1,
            moverange: 3,
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
            moverange: 4,
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
            moverange: 5,
            damage: {
                infantry: 80,
                armor: 20,
                air: 20
            }
        }
    };
    var immutableObjectType = {
        tree: {
            name: "Bonsai Tree",
            type: "unmovable",
            templateName: "ObjectForest",
            walkable: true,
            cover: true,
            maxHealth: 150
        },
        city: {
            name: "Gotham",
            type: "unmovable",
            templateName: "ObjectForest",
            walkable: true,
            cover: true,
            maxHealth: 300
        }
    };
    var maps = [
        {
            name: "Rough Neighbourhood",
            mapMatrix: [5, 5],
            objectMapping: [
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    loc: [2, 1],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    loc: [4, 3],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    loc: [4, 2],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [4, 1],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [0, 3],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    loc: [2, 4],
                    angle: 180
                }]
        },
        {
            name: "World War Z",
            mapMatrix: [22, 12],
            objectMapping: [
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    loc: [6, 10],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    loc: [8, 11],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    loc: [9, 4],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    loc: [2, 4],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    loc: [11, 6],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    loc: [16, 7],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    loc: [18, 3],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    loc: [17, 2],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [7, 6],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [9, 3],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [12, 9],
                    angle: 0
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [9, 9],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [13, 4],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [11, 7],
                    angle: 0
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    loc: [11, 8],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [8, 4],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [18, 8],
                    angle: 0
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [3, 6],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [14, 4],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [19, 8],
                    angle: 0
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [6, 0],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [9, 5],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [5, 8],
                    angle: 0
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [18, 5],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [19, 9],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [17, 7],
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    loc: [13, 9],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 0,
                    loc: [4, 3],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    loc: [5, 6],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    loc: [8, 7],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 0,
                    loc: [3, 2],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    loc: [7, 3],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    loc: [8, 5],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    loc: [11, 7],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    loc: [17, 5],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    loc: [13, 4],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    loc: [19, 5],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    loc: [16, 2],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    loc: [14, 6],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 0,
                    loc: [2, 1],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    loc: [3, 3],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    loc: [6, 7],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 0,
                    loc: [9, 4],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    loc: [4, 3],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    loc: [1, 6],
                    angle: 0
                },
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    loc: [13, 3],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    loc: [18, 0],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    loc: [16, 4],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    loc: [11, 5],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    loc: [13, 2],
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    loc: [17, 6],
                    angle: 180
                }]
        }
    ];

    var gameData = {
        name: "Standard 1 vs 1 Game",
        minPlayers: 2,
        maxPlayers: 2,
        maps: maps
    };
    var game = Games.findOne({name: gameData.name});
    if (!game) {
        Games.insert(gameData);
    }
});
