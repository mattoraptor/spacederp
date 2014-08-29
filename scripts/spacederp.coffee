class Vector
    constructor: (@start, @end) ->
        @magnitude = Math.sqrt(Math.pow(@end.x - @start.x,  2) + Math.pow(@end.y - @start.y, 2))
        @unitDirection = {x: (@end.x - @start.x) / @magnitude, y: (@end.y - @start.y) / @magnitude}

    resize: (size) ->
        new Vector @start, {x: @start.x + @unitDirection.x * size, y: @start.y + @unitDirection.y * size}

class SpaceDerp
    constructor: (@galaxy, @timeUnit, @getTime) ->

    travel: (playerData, destination) ->
        target = @galaxy[destination].location
        current = @galaxy[playerData.travel.location].location
        vec = new Vector current, @galaxy[destination].location

        distanceTraveled = vec.magnitude
        playerData.travel.location = destination

        maxDistanceOnFuel = playerData.ship.cargo.fuel * playerData.ship.lights_per_ton
        if distanceTraveled > maxDistanceOnFuel
            distanceTraveled = maxDistanceOnFuel
            playerData.travel.location = vec.resize(distanceTraveled).end

        playerData.ship.cargo.fuel = Math.max(0,
            playerData.ship.cargo.fuel - distanceTraveled / playerData.ship.lights_per_ton)
        playerData.travel.eta = @getTime() + (distanceTraveled / playerData.ship.speed) * @timeUnit
        playerData

    buy: (playerData, coinBank, item, quantity) ->
        playerData.ship.cargo[item] ?= 0
        playerData.ship.cargo[item] += quantity
        coinBank.coins -= @galaxy[playerData.travel.location].merchant[item].price * quantity
        true

module.exports = SpaceDerp