Meteor.startup(function () {
    var unitObjectType =
    {
        soldier: {
            name: "G.I. Jane",
            type: "infantry",
            templateName: "UnitRifleman",
            maxHealth: 100,
            maxStrength: 10,
            minShootingrange: 1,
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
            minShootingrange: 1,
            maxShootingrange: 5,
            moverange: 10,
            damage: {
                infantry: 100,
                armor: 50,
                air: 0
            }
        },
        bazookaSoldier: {
            name: "Bazooka Bill",
            type: "infantry",
            templateName: "UnitBazooka",
            maxHealth: 100,
            maxStrength: 8,
            minShootingrange: 1,
            maxShootingrange: 2,
            moverange: 5,
            damage: {
                infantry: 20,
                armor: 100,
                air: 50
            }
        }
    };
    var maps = [
        {
            name: "TestMap",
            mapMatrix: [5, 5],
            objectMapping: [
                {
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 0,
                    x: 2,
                    y: 1
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 4,
                    y: 3
                },
                {
                    unitObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 0,
                    x: 4,
                    y: 2
                }]
        },
        {
            name: "AnotherTestMap",
            mapMatrix: [20, 20],
            objectMapping: [
                {
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 0,
                    x: 4,
                    y: 15,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    x: 5,
                    y: 17,
                    angle: 90
                },
                {
                    gameObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 0,
                    x: 8,
                    y: 7,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 0,
                    x: 3,
                    y: 12,
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
                    gameObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 0,
                    x: 8,
                    y: 16,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 1,
                    x: 11,
                    y: 16,
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
                    gameObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 1,
                    x: 13,
                    y: 17,
                    angle: 270
                },{
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 1,
                    x: 19,
                    y: 18,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 16,
                    y: 18,
                    angle: 270
                },
                {
                    gameObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 1,
                    x: 14,
                    y: 6,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 0,
                    x: 2,
                    y: 15,
                    angle: 90
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 0,
                    x: 3,
                    y: 17,
                    angle: 90
                },
                {
                    gameObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 0,
                    x: 6,
                    y: 7,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 0,
                    x: 9,
                    y: 12,
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
                    gameObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 0,
                    x: 1,
                    y: 16,
                    angle: 90
                },{
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 1,
                    x: 13,
                    y: 16,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 18,
                    y: 5,
                    angle: 270
                },
                {
                    gameObjectType: unitObjectType.bazookaSoldier,
                    playerIndex: 1,
                    x: 16,
                    y: 17,
                    angle: 270
                },{
                    unitObjectType: unitObjectType.soldier,
                    playerIndex: 1,
                    x: 11,
                    y: 18,
                    angle: 270
                },
                {
                    unitObjectType: unitObjectType.tank,
                    playerIndex: 1,
                    x: 13,
                    y: 18,
                    angle: 270
                },
                {
                    gameObjectType: unitObjectType.bazookaSoldier,
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
