#############################################################################
# A method to play the next move
#############################################################################
def playmove(game)
    # playermode = game[:playermode]
    # currentplayer = game[:currentplayer]
    # board = game[:board]
    # moverecord = game[:moverecord]
    # commands = game[:commands]
    # board_display = game[:board_display]
    # player = game[:player]
  
    if game[:playermode] == 1 and game[:currentplayer][:name] == "Computer"
      computermove(game)
      currentplayer = swapturn(game[:currentplayer], game[:player])
    end
  
    begin
      
    end while not (validatecommand(commands, board, board_display, command))
  
    moverecord.push(cmd_parse)
    board[cmd_parse[0]][cmd_parse[1]] = currentplayer[:val]
    board_display[display_parse[0]][display_parse[1]] = currentplayer[:str]
  end
  
  #############################################################################
  # A method to check if the entered command is valid
  #############################################################################
  def validatecommand(game, command)
    cmd_parse = commandparser(game[:commands], game[:board_display], command)
    display_parse = displayparser(game[:commands], command)
    if (cmd_parse[0] == -1 or cmd_parse[0] == -1)
      puts "\n\t\t\"#{command}\" is not a valid command. Enter \"H\" for help."
      return false
    end
    if (!game[:board][cmd_parse[0]][cmd_parse[1]].nil?)
      puts "\n\t\t\"#{command}\" is not an empty space"
      return false
    end
    return [cmd_parse, display_parse]
  end