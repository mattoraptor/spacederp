class SpaceDerp
    constructor: (@galaxy, @timeUnit, @getTime) ->

    travel: (playerData, destination) ->
        target = @galaxy[destination].location
        current = @galaxy[playerData.travel.location].location
        direction = {x: target.x - current.x, y: target.y - current.y}
        magnitude = Math.sqrt(Math.pow(direction.x, 2) + Math.pow(direction.y, 2))

        distanceTraveled = magnitude
        playerData.travel.location = destination
        
        if magnitude > playerData.ship.cargo.fuel * playerData.ship.lights_per_ton
            distanceTraveled = playerData.ship.cargo.fuel * playerData.ship.lights_per_ton
            traveled = {x: (direction.x / magnitude) * distanceTraveled, y: (direction.y / magnitude) * distanceTraveled}
            playerData.travel.location = {x: current.x + traveled.x, y: current.y + traveled.y}

        playerData.ship.cargo.fuel = Math.max(0, 
            playerData.ship.cargo.fuel - distanceTraveled / playerData.ship.lights_per_ton)
        playerData.travel.eta = @getTime() + (distanceTraveled / playerData.ship.speed) * @timeUnit
        playerData

module.exports = SpaceDerp