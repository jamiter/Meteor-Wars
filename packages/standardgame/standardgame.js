Meteor.startup(function () {
    var unitObjectType =
    {
        rifleman: {
            name: "G.I. Jane",
            type: "infantry",
            templateName: "UnitRifleman",
            maxHealth: 100,
            maxStrength: 10,
            minShootingrange: 0,
            maxShootingrange: 1,
            moverange: 5,
            damage: {
                infantry: 50,
                armor: 10,
                air: 0
            }
        },
        tank: {
            name: "M1 Abrams",
            type: "armor",
            templateName: "UnitTank",
            maxHealth: 250,
            maxStrength: 4,
            minShootingrange: 0,
            maxShootingrange: 5,
            moverange: 8,
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
            maxStrength: 8,
            minShootingrange: 0,
            maxShootingrange: 3,
            moverange: 4,
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
            maxStrength: 8,
            minShootingrange: 0,
            maxShootingrange: 2,
            moverange: 10,
            damage: {
                infantry: 100,
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
                    x: 2,
                    y: 1,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 4,
                    y: 3,
                    angle: 180
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    x: 4,
                    y: 2,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 4,
                    y: 1,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 0,
                    y: 3,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    x: 2,
                    y: 4,
                    angle: 270
                }]
        },
        {
            name: "World War Z",
            mapMatrix: [22, 12],
            objectMapping: [
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    x: 6,
                    y: 10,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    x: 8,
                    y: 11,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    x: 9,
                    y: 4,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 0,
                    x: 2,
                    y: 4,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    x: 11,
                    y: 6,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    x: 16,
                    y: 7,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    x: 18,
                    y: 3,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.jeep,
                    playerIndex: 1,
                    x: 17,
                    y: 2,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 7,
                    y: 6,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 9,
                    y: 3,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 12,
                    y: 9,
                    angle: 90
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 9,
                    y: 9,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 13,
                    y: 4,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 11,
                    y: 7,
                    angle: 90
                },
                {
                    immutableObjectType: immutableObjectType.city,
                    x: 11,
                    y: 8,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 8,
                    y: 4,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 18,
                    y: 8,
                    angle: 90
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 3,
                    y: 6,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 14,
                    y: 4,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 19,
                    y: 8,
                    angle: 90
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 6,
                    y: 10,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 9,
                    y: 5,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 5,
                    y: 8,
                    angle: 90
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 18,
                    y: 5,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 19,
                    y: 9,
                    angle: 270
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 17,
                    y: 7,
                    angle: 180
                },
                {
                    immutableObjectType: immutableObjectType.tree,
                    x: 13,
                    y: 9,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 0,
                    x: 4,
                    y: 3,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    x: 5,
                    y: 6,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    x: 8,
                    y: 7,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 0,
                    x: 3,
                    y: 2,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    x: 7,
                    y: 3,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    x: 8,
                    y: 5,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    x: 11,
                    y: 7,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 17,
                    y: 5,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    x: 13,
                    y: 4,
                    angle: 270
                },{
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    x: 19,
                    y: 5,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 16,
                    y: 2,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    x: 14,
                    y: 6,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 0,
                    x: 2,
                    y: 1,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    x: 3,
                    y: 3,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    x: 6,
                    y: 7,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 0,
                    x: 9,
                    y: 4,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    x: 4,
                    y: 3,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 0,
                    x: 1,
                    y: 6,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    x: 13,
                    y: 3,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 18,
                    y: 10,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    x: 16,
                    y: 4,
                    angle: 270
                },{
                    unitObjectType: unitObjectType.rifleman,
                    playerIndex: 1,
                    x: 11,
                    y: 5,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 13,
                    y: 2,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.bazooka,
                    playerIndex: 1,
                    x: 17,
                    y: 6,
                    angle: 270
                }]
        }
    ];

    var game = {
        name: 'Standard 1 vs 1 Game',
        playersRequirement: 2,
        maps: maps
    };
    var findGame = Games.findOne({name: game.name});
    if (!findGame) {
        Games.insert(game);
    }
});
