getNewLocation = (current, target, distance) ->
    direction = {x: target.x - current.x, y: target.y - current.y}
    magnitude = Math.sqrt(Math.pow(direction.x, 2) + Math.pow(direction.y, 2))
    traveled = {x: (direction.x / magnitude) * distance, y: (direction.y / magnitude) * distance}
    {x: current.x + traveled.x, y: current.y + traveled.y}

class SpaceDerp
    constructor: (@galaxy, @timeUnit, @getTime) ->

    travel: (playerData, destination) ->
        destloc = @galaxy[destination].location
        curloc = @galaxy[playerData.travel.location].location
        
        distance = Math.min(
            Math.sqrt(Math.pow(destloc.y - curloc.y,2) + Math.pow(destloc.x - curloc.x,2)),
            playerData.ship.cargo.fuel * playerData.ship.lights_per_ton)
        if distance == playerData.ship.cargo.fuel * playerData.ship.lights_per_ton
            playerData.travel.location = getNewLocation curloc, destloc, distance
        else
            playerData.travel.location = destination

        playerData.ship.cargo.fuel = Math.max(0, 
            playerData.ship.cargo.fuel - distance / playerData.ship.lights_per_ton)
        playerData.travel.eta = @getTime() + (distance / playerData.ship.speed) * @timeUnit
        playerData

module.exports = SpaceDerp