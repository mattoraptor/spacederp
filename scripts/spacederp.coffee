class SpaceDerp
    constructor: (@galaxy, @timeUnit, @getTime) ->

    travel: (playerData, destination) ->
        destloc = @galaxy[destination].location
        curloc = @galaxy[playerData.travel.location].location
        distance = Math.sqrt(Math.pow(destloc.y - curloc.y,2) + Math.pow(destloc.x - curloc.x,2))
        if playerData.ship.cargo.fuel * playerData.ship.lights_per_ton < distance
            moved = playerData.ship.cargo.fuel * playerData.ship.lights_per_ton
            dir = {x: (destloc.x - curloc.x), y: (destloc.y - curloc.y)}
            mag = Math.sqrt(Math.pow(dir.x, 2) + Math.pow(dir.y,2))
            udir = {x: dir.x / mag, y: dir.y / mag}
            playerData.ship.cargo.fuel = 0
            location = 
                x: curloc.x + udir.x * moved
                y: curloc.y + udir.y * moved
            playerData.travel.location = location
            playerData.travel.eta = @getTime() + moved * playerData.ship.speed
        else
            playerData.travel.location = destination
            playerData.travel.eta = @getTime() + (distance / playerData.ship.speed) * @timeUnit
            playerData.ship.cargo.fuel -= distance / playerData.ship.lights_per_ton
        playerData

module.exports = SpaceDerp