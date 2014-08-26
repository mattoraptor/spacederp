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

describe "SpaceDerp", ->
    describe "#travel()", ->
        playerData = null
        space = null

        beforeEach ->
            playerData = setupPlayer()
            space = new SpaceDerp setupGalaxy(), 5, fakeGetTime

        it 'takes fuel and time and supplies',  ->
            {travel: {location, eta}, ship: {cargo: {fuel}}} = space.travel playerData, 'lol asteroids'
            location.should.be.exactly('lol asteroids')
            # distance = 9, speed = 3, 3 time units travel, eta = 3 * 5 = 15
            eta.should.be.exactly(100 + (3 * 5))
            fuel.should.be.exactly(60 - (9 / 4))

        it 'can leave you stranded', ->
            playerData.ship.cargo.fuel = 2
            {travel: {location, eta}, ship: {cargo: {fuel}}} = space.travel playerData, 'lol asteroids'
            fuel.should.be.exactly(0)
            location.x.should.be.exactly(8)
            location.y.should.be.exactly(4)
            eta.should.be.exactly(100 + (8/3) * 5)
