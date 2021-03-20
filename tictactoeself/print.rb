#############################################################################
# A method to draw the board
#############################################################################
def showboard(board)
    for i in 0..7
      puts "\t\t\t\t\t" + board[i]
    end
end




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

  return player
end

#############################################################################
# A method that shows "Help" feature
#############################################################################
def showhelp(board)
  puts "\n\\t\t****** HELP ***************************************************************"
  puts "\nThis is the tic-tac-toe board..."
  showboard(board)
  puts "\n\n\t\tEnter the following text commands: \n\n\t\t\t\"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\".\n\n\t\tThey correspond to each cell on the board..."
  puts "\n\t\t\"H\" displays Help"
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
# A method to print the title screen
#############################################################################
def showtitlescreen(board)
  # Title Screen
  puts "\n\n\n\t\t*****************************************************************************"
  puts "\t\t*                                                                           *"
  puts "\t\t*             Welcome to Tic-Tac-Toe Version 1.0 by Punit Dh                *"
  puts "\t\t*                                                                           *"
  puts "\t\t*****************************************************************************\n\n\n\n"
  for i in 0..7
    puts "\t\t\t\t\t\t" + board[i]
  end
  print "\n\n\n\n\t\t\t\t\tPress ENTER or RETURN to START THE GAME"
  tmp = gets

  print "\n\n\t\tWelcome to Tic-Tac-Toe...\n\n\t\tYou can player in either single or multiplayer mode...(Press ENTER)"
  tmp = gets

  print "\n\n\t\t\'X\' always goes first..."
  tmp = gets

  print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
  tmp = gets

  print "\n\n\t\tYou play by giving the following text commands:\n\n\t\t\t \"A1\", \"A2\", \"A3\", \"B1\", \"B2\", \"B3\", \"C1\", \"C2\", \"C3\"."#\n\n\t\tThey correspond to each cell on the board..."
  tmp = gets

  print "\n\t\tYou can enter the text command \"H\" for Help if you get stuck or lost..."
  tmp = gets

  print "\n\t\tPress Ctrl+C or Cmd+C to exit the game at any time..."
  tmp = gets

  print "\n\n\t\tLet's get started..."
  tmp = gets
end