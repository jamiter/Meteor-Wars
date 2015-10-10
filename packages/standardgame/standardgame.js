Meteor.startup(function () {
    var gameObjects = {
        emptyField: {
            image: "/images/emptyField"
        },
        tree: {
            image: "/images/tree"
        }
    };
    var maps = [
        {
            name: "TestMap",
            mapMatrix: [10, 10],
            objectMapping: [{
                gameObject: 'tree',
                x: 5,
                y: 3
            }, {
                objectType: 'tree',
                x: 8,
                y: 3
            }]
        },
        {
            name: "TestMap",
            mapMatrix: [10, 10],
            objectMapping: [{
                objectType: gameObjects.tree,
                x: 5,
                y: 3
            }, {
                objectType: gameObjects.tree,
                x: 8,
                y: 3
            }]
        }
    ];

    var game = {
        name: 'Standard 1 vs 1 Game',
        playersRequirement: 2,
        gameObjects: gameObjects,
        maps: maps
    };
    var findGame = Games.findOne({name: game.name});
    if (!findGame) {
        Games.insert(game)
    }
});


