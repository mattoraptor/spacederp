class SpaceDerp
    constructor: (@galaxy, @timeUnit, @getTime) ->

    travel: (playerData, destination) ->
        destloc = @galaxy[destination].location
        curloc = @galaxy[playerData.travel.location].location
        playerData.travel.location = destination
        distance = Math.sqrt(Math.pow(destloc.y - curloc.y,2) + Math.pow(destloc.x - curloc.x,2))
        playerData.travel.eta = @getTime() + (distance / playerData.ship.speed) * @timeUnit
        playerData

module.exports = SpaceDerp