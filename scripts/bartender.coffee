# Description:
#   Keep track of drinks
#
# Dependencies:
#   None
#
# Configuration:
#   BARTENDER_ALLOW_SELF
#
# Commands:
#
#   drink please <drinkname> - request drink
#   drink nevermind - cancel user request
#   drink thanks - ack receiving drink
#   drink requests - list requests
#   drink clearall - clear orders
#
# Author:
#   sebastian

class Bartender

  @millisInDay = 24 * 60 * 60 * 1000

  request: (user, thing) ->
    @cache[user] = thing
    @robot.brain.data.bartender = @cache

  remove: (user) ->
    delete @cache[user]
    @robot.brain.data.bartender = @cache

  clear: ->
    @cache = []
    @robot.brain.data.bartender = @cache

  setupClear: ->
    clear
    setInterval @millisInDay, -> clear

  constructor: (@robot) ->
    @cache = {}

    @robot.brain.on 'loaded', =>
      if @robot.brain.data.bartender
        @cache = @robot.brain.data.bartender

    @midnightInMillis = Math.floor((new Date).getTime / @millisInDay) \
                       * @millisInDay + @millisInDay
    @millisUntilMidnight = @midnightInMillis - (new Date).getTime
    setTimeout @millisUntilMidnight / 1000, -> setupClear


module.exports = (robot) ->
  bartender = new Bartender robot
  allow_self = process.env.BARTENDER_ALLOW_SELF or "true"

  robot.respond /drink please (\S+[^-\s])$/i, (msg) ->
    user = msg.message.user.name.toLowerCase()
    drink = msg.match[1].toLowerCase()
    bartender.request user, drink
    msg.send "Got it!"

  robot.respond /drink nevermind?$/i, (msg) ->
    user = msg.message.user.name.toLowerCase()
    bartender.remove user
    msg.send "No problem."

  robot.respond /drink thanks?$/i, (msg) ->
    user = msg.message.user.name.toLowerCase()
    bartender.remove user
    msg.send "Your welcome!"

  robot.respond /drink requests?$/i, (msg) ->
    verbiage = ["- Requests -"]
    for user, drink of bartender.cache
      verbiage.push "#{user}: #{drink}"
    console.log bartender.cache
    msg.send verbiage.join("\n")

  robot.respond /drink clearAll?$/i, (msg) ->
    bartender.clear
    msg.send "All gone."

