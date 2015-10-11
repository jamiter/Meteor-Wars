Meteor.startup(function () {
    var unitObjectType =
    {
        soldier: {
            name: "G.I. Jane",
            type: "infantry",
            image: "/images/soldier",
            health: 100,
            minShootingrange: 1,
            maxShootingrange: 1,
            moverange: 5,
            damage: {
                infantry: 50,
                armor: 10,
                air: 0
            }
        }
        ,
        tank: {
            name: "M1 Abrams",
            type: "armor",
            image: "/images/tank",
            health: 250,
            minShootingrange: 1,
            maxShootingrange: 5,
            moverange: 10,
            damage: {
                infantry: 100,
                armor: 50,
                air: 0
            }
        }
        ,
        bazookaSoldier: {
            name: "Bazooka Bill",
            type: "infantry",
            image: "/images/bazookaSoldier",
            health: 80,
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
                    position: [2, 1]
                },
                {
                    unitObjectType: unitObjectType.tank,
                    position: [5, 3]
                },
                {
                    unitObjectType: unitObjectType.bazookaSoldier,
                    position: [4, 2]
                }]
        },
        {
            name: "AnotherTestMap",
            mapMatrix: [20, 20],
            objectMapping: [
                {
                    unitObjectType: unitObjectType.soldier,
                    position: [2, 3]
                },
                {
                    unitObjectType: unitObjectType.tank,
                    position: [17, 3]
                },
                {
                    gameObjectType: unitObjectType.bazookaSoldier,
                    position: [18, 2]
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
        Games.insert(game)
    }
});


