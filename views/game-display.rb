#############################################################################
# A method to draw the board
#############################################################################
def showboard(game)
    game.board_display.map.with_index do |row,i|
      str = game.board_display[i].split("X").join("X".light_red)
      str = str.split("O").join("O".light_blue)
      puts "\t\t\t\t\t" + str
    end
end

#############################################################################
# A method used to choose the player mode
#############################################################################
def chooseplayermode()
  prompt = TTY::Prompt.new(symbols: {marker: " "})
  choices = {"\n\n\t\t\t\t\t   (1)-Player Mode": 1, "\n\t\t\t\t\t   (2)-Player Mode": 2}
  playermode = prompt.select("\n\n\t\t\t\t\tChoose (1)-player or (2)-player mode:", choices, show_help: :never)
  return playermode
end

#############################################################################
# A method to get the player names and save them in a hash
#############################################################################
def getplayernames(playermode)
  player = Array.new    # Set default values below
  player[0] = Player.new("Player 1")
  player[1] = Player.new("Player 2")

  # Get player names
  for i in 0..playermode-1
    getname(player[i], i)
    player[1].name = (playermode == 1) ? "Computer" : next
  end

  # Welcome the players
    print (playermode == 1) ? "\n\n\t\tWelcome #{player[0].name}!" : "\n\n\t\tWelcome #{player[0].name} and #{player[1].name}!"
  tmpgets

  return player
end

#############################################################################
# A method to get the player names
#############################################################################
def getname(player, index)
  print "\n\t\tEnter #{player.name} Name: "
  name = gets.chomp
  player.name = (name.length == 0) ? "Player #{index+1}" : name
end

#################################################################################
# A method used to choose first player
#################################################################################
def selectfirstplayer(player)
  # Coin toss
  print "\n\n\t\tTossing coin now...(Press ENTER to see coin toss results)"
  tmpgets

  currentplayer = cointoss(player) 

  puts "\n\t\tThe result of the coin toss is: \n\n"
  puts "\t\t\t\t\t\t\t  -------  "
  puts "\t\t\t\t\t\t\t/         \\"
  puts "\t\t\t\t\t\t\t|    #{currentplayer[1]}    |"
  puts "\t\t\t\t\t\t\t\\         /"
  print "\t\t\t\t\t\t\t  -------- "

  tmpgets

  # Set current player based on who has X or O
  # currentplayer = (player[1].val == 1) ? player[1] : player[0]
  puts "\n\t\t#{player[0].name} is \'#{player[0].str}\'. #{player[1].name} is \'#{player[1].str}\'.\n\n"
  print "\t\t#{currentplayer[0].name} goes first..."
  tmpgets

  return currentplayer[0]
end

#############################################################################
# A method that shows "Help" feature
#############################################################################
def showhelp(game)
  puts ("\n\t\t***************************************************************************" * 5)
  puts "\t\t*******************************    HELP    ********************************"
  puts "\n\t\tThis is the tic-tac-toe board..."
  showboard(game)
  puts "\n\n\t\tEnter the following text commands: \n\n\t\t\t\"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\".\n\n\t\tThey correspond to each cell on the board..."
  puts "\n\t\t\"R\" to play a random move"
  puts "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time"
end

#############################################################################
# A debug method used to draw a simpler version of the board
#############################################################################
def showsimpleboard(board)
  print "\n"
  print "\t\t|---------------| \n"
  board.map do |row|
    print "\t\t"
    row.map do |cell|
      print cell.nil? ? "|    " : "|  " + cell.to_s + " "
    end
    print " |\n"
    print "\t\t|---------------| \n"
  end
end

#################################################################################
# A method used to generate a cointoss, assign X and O
#################################################################################
def cointoss(player)
  vals = [ ["O",0], ["X",1] ]
  rtoss = rand().round
  player[rtoss].str, player[rtoss].val = vals[rtoss]
  player[otherval(rtoss)].str, player[otherval(rtoss)].val = vals[otherval(rtoss)]
  ctoss = (rtoss < 0.5) ? "T" : "H"
  # randtoss = (rand())
  # player[0].str, player[0].val = (randtoss < 0.5) ? ["O",0] : ["X",1]
  # player[1].str, player[1].val = (randtoss < 0.5) ? ["X",1] : ["O",0]

  return [currentplayer = (player[1].val == 1) ? player[1] : player[0], ctoss]
end

#############################################################################
# Show title prompts
#############################################################################
def showtitleprompts()
	print "\n\n\t\tLet's get started."
	return if (tmpgets.upcase == "S")

	print "\n\n\t\t\'X\' always goes first..."
	return if (tmpgets.upcase == "S")

	print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
	return if (tmpgets.upcase == "S")

	print "\n\n\t\tYou play by giving the following text commands:\n\n\t\t\t \"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\"."
	return if (tmpgets.upcase == "S")

	print "\n\t\tYou can enter the text command \"H\" for Help if you get stuck or lost..."
	return if (tmpgets.upcase == "S")

	print "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time..."
end