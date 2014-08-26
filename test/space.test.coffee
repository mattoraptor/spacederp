SpaceDerp = require '../scripts/spacederp'

setupGalaxy = ->
    galaxy = {}
    galaxy['derpbase 1'] = {location: {x: 0, y: 4}}
    galaxy['lol asteroids'] = {location: {x: 9, y: 4}}
    galaxy

fakeGetTime = ->
    100

exports.SpaceTest =
    setUp: (callback) ->

        @space = new SpaceDerp setupGalaxy(), 5, fakeGetTime
        callback()

    'traveling takes fuel and time and supplies': (test) ->
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

    'traveling can leave you stranded': (test) ->
        test.done()

