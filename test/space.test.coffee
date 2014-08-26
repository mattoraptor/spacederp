SpaceDerp = require '../scripts/spacederp'

exports.SpaceTest =
    setUp: (callback) ->
        galaxy = {}
        galaxy['derpbase 1'] = {location: {x: 0, y: 4}}
        galaxy['lol asteroids'] = {location: {x: 9, y: 4}}
        getTime = ->
            100
        @space = new SpaceDerp galaxy, 5, getTime
        callback()

    'travelling takes fuel and time and supplies': (test) ->
        playerData = 
            travel: 
                location: 'derpbase 1'
                eta: null
            ship:
                speed: 3
                lights_per_ton: 4
                crew: 8
                cargo:
                    max: 100
                    fuel: 60
                    supplies: 40
        
        {travel: {location, eta}, ship: {cargo: {fuel}}} = @space.travel playerData, 'lol asteroids'
        # distance = 9, speed = 3, 3 time units travel, eta = 3 * 5 = 15
        test.equals(location, 'lol asteroids')
        test.equals(eta, 100 + (3 * 5))
        test.equals(fuel, 60 - (9 * 4))
        test.done()
