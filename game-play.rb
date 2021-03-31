#############################################################################
# A method to let the player play the next move
#############################################################################
def playermove(game, currentplayer)
  begin
    print "\n\t\t#{currentplayer.name}, please enter a command: "
    command = gets.chomp.strip.upcase.delete(' ')
    puts "\n\t\tYou (#{currentplayer.str}) entered: \"#{command}\""
    cmd_parse = validatecommand(game, command)
  end while not cmd_parse
  game.moverecord.push(cmd_parse)
  game.playmove(cmd_parse,currentplayer.val)
  currentplayer = swapturn(currentplayer, game.players)
  # currentplayer = entermove(game, currentplayer, cmd_parse)
end

#############################################################################
# A method to assign the move to the board then swap the turn
#############################################################################
def entermove(game, currentplayer, cmd_parse)
  game.playmove(cmd_parse,currentplayer.val)
  return swapturn(currentplayer, game.players)
end

#############################################################################
# A method to let the next player play, returns "nextplayer"
#############################################################################
def nextgameplayer?(game, nextplayer)
  return ((game.playermode == 1) and (nextplayer == game.players[1]))
end