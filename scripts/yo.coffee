# Description:
#   Yo.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   dannymcc

responses = [
  ":yo:"
]

# http://en.wikipedia.org/wiki/You_talkin'_to_me%3F
youTalkinToMe = (msg, robot) ->
  input = msg.message.text.toLowerCase()
  name = robot.name.toLowerCase()
  input.match(new RegExp('\\b' + name + '\\b', 'i'))?

module.exports = (robot) ->
  robot.hear /\b(yo)\b/i, (msg) ->
    msg.send msg.random responses if youTalkinToMe(msg, robot)
