assert = require "assert"
SpaceDerp = require '../scripts/spacederp'

setupGalaxy = ->
    galaxy = {}
    galaxy['derpbase 1'] = {location: {x: 0, y: 4}}
    galaxy['lol asteroids'] = {location: {x: 9, y: 4}}
    galaxy

setupPlayer = ->
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
    playerData

fakeGetTime = ->
    100

describe "SpaceDerpTests", ->

    playerData = null
    space = null

    beforeEach ->
        playerData = setupPlayer()
        space = new SpaceDerp setupGalaxy(), 5, fakeGetTime

    it 'traveling takes fuel and time and supplies',  ->
        {travel: {location, eta}, ship: {cargo: {fuel}}} = space.travel playerData, 'lol asteroids'
        assert.equal(location, 'lol asteroids')
        # distance = 9, speed = 3, 3 time units travel, eta = 3 * 5 = 15
        assert.equal(eta, 100 + (3 * 5))
        #fuel cost = distance * lights_per_ton
        assert.equal(fuel, 60 - (9 / 4))

    it 'traveling can leave you stranded', ->
        playerData.ship.cargo.fuel = 2
        {travel: {location:{x, y}, eta}, ship: {cargo: {fuel}}} = space.travel playerData, 'lol asteroids'
        assert.equal(fuel, 0)
        assert.equal(x, 8)
        assert.equal(y, 4)
        assert.equal(eta, 100 + (8/3) * 5)
