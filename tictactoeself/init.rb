#############################################################################
# A method that creates a new game
#############################################################################
def createnewgame()
  # Initialise
  board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
  commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
  moverecord = Array.new
  board_display = displayboard()

  # Show title screen and get player info
  showtitlescreen(board_display)
  playermode = chooseplayermode()
  player = getplayernames(playermode)
  
  game = {"board": board, "playermode": playermode, "player": player, "moverecord": moverecord, "commands": commands, "board_display": board_display}

  return game
end

#############################################################################
# A method to draw the board
#############################################################################
def showboard(game)
    for i in 0..7
      puts "\t\t\t\t\t" + game[:board_display][i]
    end
end

#############################################################################
# A method used to choose the player mode
#############################################################################
def chooseplayermode()
  begin
    print "\n\t\tChoose (1)-player or (2)-player mode: "
    playermodeget = gets.chomp
    playermode = playermodeget.to_i
    if (playermodeget.length == 0)
      playermode = 1
      puts "\n\t\tAutomatically selecting (1)-player mode...\n"
      break
    elsif (playermode < 1 or playermode > 2)
      puts "\n\t\t\"#{playermodeget}\" is not a valid player mode. Enter 1 or 2:\n"
    end
  end while not (playermode == 1 or playermode == 2 or playermodeget.length == 0)
  return playermode
end

#############################################################################
# A method to get the player names and save them in a hash
#############################################################################
def getplayernames(playermode)
  player = Array.new
  player[0] = {name: "Player 1", val: -1, str: ""}
  player[1] = {name: "Player 2", val: -1, str: ""}

  # Get player 1 name
  print "\n\t\tEnter #{player[0][:name]} Name: "
  player[0][:name] = gets.chomp
  if player[0][:name] == ""
    player[0][:name] = "Player 1"
  end

  # If two-player mode, get second player's name, or else use "Computer"
  if (playermode == 2)
    print "\n\t\tEnter #{player[1][:name]} Name: "
    player[1][:name] = gets.chomp
    if player[1][:name] == ""
      player[1][:name] = "Player 2"
    end
  elsif playermode == 1
    player[1][:name] = "Computer"
  end

  # Welcome the players
  if playermode == 1
    print "\n\n\t\tWelcome #{player[0][:name]}!"
  elsif playermode == 2
    print "\n\n\t\tWelcome #{player[0][:name]} and #{player[1][:name]}!"
  end
  tmpgets

  return player
end

#################################################################################
# A method used to generate a cointoss, assign X and O, and choose first player
#################################################################################
def cointoss(player)
  # Coin toss
  print "\n\n\n\t\tTossing coin now...(Press ENTER to see coin toss results)"
  tmpgets

  # Generate a random value
  randtoss = (rand()*2)

  # Display the coin toss
  cointoss = (randtoss < 1) ? "T" : "H"
  player[0][:str], player[0][:val] = (randtoss < 1) ? ["O", 0] : ["X", 1]
  player[1][:str], player[1][:val] = (randtoss < 1) ? ["X", 1] : ["O", 0] 

  puts "\n\t\tThe result of the coin toss is: \n\n"
  puts "\t\t\t\t\t\t\t  -------  "
  puts "\t\t\t\t\t\t\t/         \\"
  puts "\t\t\t\t\t\t\t|    #{cointoss}    |"
  puts "\t\t\t\t\t\t\t\\         /"
  print "\t\t\t\t\t\t\t  -------- "

  tmpgets

  # Set current player based on who has X or O
  if player[1][:val] == 1
    currentplayer = player[1]
  elsif player[0][:val] == 1
    currentplayer = player[0]
  end

  puts "\n\t\t#{player[0][:name]} is \'#{player[0][:str]}\'. #{player[1][:name]} is \'#{player[1][:str]}\'.\n\n"

  # Determining who goes first
  print "\t\t#{currentplayer[:name]} goes first..."
  tmpgets

  return currentplayer
end

#############################################################################
# A method used to generate the board display
#############################################################################
def displayboard()

  board_display = ["     1   2   3  ",
    "   |---|---|---|",
    " A |   |   |   |",
    "   |---|---|---|",
    " B |   |   |   |",
    "   |---|---|---|",
    " C |   |   |   |",
    "   |---|---|---|"]

    return board_display
end

#############################################################################
# A method to get the player names and save them in a hash
#############################################################################
def getplayernames(playermode)
  player = Array.new
  player[0] = {name: "Player 1", val: -1, str: ""}
  player[1] = {name: "Player 2", val: -1, str: ""}

  # Get player 1 name
  print "\n\t\tEnter #{player[0][:name]} Name: "
  player[0][:name] = gets.chomp
  if player[0][:name] == ""
    player[0][:name] = "Player 1"
  end

  # If two-player mode, get second player's name, or else use "Computer"
  if (playermode == 2)
    print "\n\t\tEnter #{player[1][:name]} Name: "
    player[1][:name] = gets.chomp
    if player[1][:name] == ""
      player[1][:name] = "Player 2"
    end
  elsif playermode == 1
    player[1][:name] = "Computer"
  end

  # Welcome the players
  if playermode == 1
    print "\n\n\t\tWelcome #{player[0][:name]}!"
  elsif playermode == 2
    print "\n\n\t\tWelcome #{player[0][:name]} and #{player[1][:name]}!"
  end
  tmpgets

  return player
end

#############################################################################
# A method that shows "Help" feature
#############################################################################
def showhelp(game)
  puts "\n\t\t****** HELP ***************************************************************"
  puts "\n\t\tThis is the tic-tac-toe board..."
  showboard(game)
  puts "\n\n\t\tEnter the following text commands: \n\n\t\t\t\"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\".\n\n\t\tThey correspond to each cell on the board..."
  # puts "\n\t\t\"H\" displays Help"
  puts "\t\tPress Ctrl + C to exit the game at any time"
end
  
#############################################################################
# A debug method used to draw a simpler version of the board
#############################################################################
def showsimpleboard(board)
  print "\n"
  print "\t\t|---------------| \n"
  for i in 0..2
    print "\t\t"
    for j in 0..2
      print board[i][j].nil? ? "|    " : "|  " + board[i][j].to_s + " "
    end
    print " |\n"
    print "\t\t|---------------| \n"
  end
end

#############################################################################
# A method used to get a 'nil' user input
#############################################################################
def tmpgets
  tmp = gets
  return nil
end

#############################################################################
# A method to print the title screen
#############################################################################
def showtitlescreen(board_display)
  # Title Screen
  puts "\n\n\n\t\t*****************************************************************************"
  puts "\t\t*                                                                           *"
  puts "\t\t*            Welcome to UNBEATABLE TIC-TAC-TOE V1.2 by Punit Dh             *"
  puts "\t\t*                                                                           *"
  puts "\t\t*****************************************************************************\n\n\n\n"
  for i in 0..7
    puts "\t\t\t\t\t" + board_display[i]
  end
  print "\n\n\n\n\t\t\t\tPress ENTER or RETURN to START THE GAME"
  tmpgets

  print "\n\n\t\tWelcome to UNBEATABLE TIC-TAC-TOE...\n\n\t\tThis version of TIC-TAC-TOE uses the MINIMAX algorithm to find the best move..."
  tmpgets

  print "\n\n\t\tIn other words, it is unbeatable..."
  tmpgets

  print "\n\n\t\tGROUND RULES:"
  tmpgets

  print "\n\n\t\t\'X\' always goes first..."
  tmpgets

  print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
  tmpgets

  print "\n\n\t\tYou play by giving the following text commands:\n\n\t\t\t \"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\"."#\n\n\t\tThey correspond to each cell on the board..."
  tmpgets

  print "\n\t\tYou can enter the text command \"H\" for Help if you get stuck or lost..."
  tmpgets

  print "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time..."
  tmpgets

  print "\n\n\t\tLet's get started..."
  tmpgets
end
