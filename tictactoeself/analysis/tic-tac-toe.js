//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method to draw the board
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function showboard(board){
  for i in 0..7
    puts "\t\t\t\t\t" + board[i]
  }
}

function showsimpboard(board){
  print "\n"
  print "\t\t|---------------| \n"
  for i in 0..2
    print "\t\t"
    for j in 0..2
      if (board[i][j].nil?)
        print "|    "
      else
        print "|  " + board[i][j].to_s + " "
      }
    }
    print " |\n"
    print "\t\t|---------------| \n"
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method to check win states
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function checkwin(board){
  // All win states:
  // Row A, Row B, Row C
  // Column 1, Column 2, Column 3
  // A1, B2, C3
  // C1, B2, A3

  for i in 0..2
    // Check each column
    if (board[0][i] != nil and board[1][i] != nil and board[2][i] != nil)
      if (board[0][i] == board[1][i] and board[1][i] == board[2][i] and board[2][i] == board[0][i])
        winner = board[0][i]
        return winner
      }
    }

    // Check each row
    if (board[i][0] != nil and board[i][1] != nil and board[i][2] != nil)
      if (board[i][0] == board[i][1] and board[i][1] == board[i][2] and board[i][0] == board[i][2])
        winner = board[i][0]
        return winner
      }
    }
  }

    // Diagonal A1, B2, C3
    if (!(board[0][0] or board[1][1] or board[2][2]).nil? and (board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[0][0] == board[2][2]))
      winner = board[0][0]
      return winner
    }

    // Diagonal C1, B2, A3
    if (!(board[0][2] or board[1][1] or board[2][0]).nil? and (board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[0][2] == board[2][0]))
      winner = board[1][1]
      return winner
    }

  return false
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method to check draw states
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function checkdraw(board){
  for i in 0..2
    for j in 0..2
      if board[i][j]==nil
        //puts "\tNOT A DRAW"
        return false
      }
    }
  }
  return true
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method to check game } status
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function checkgameover(board){

  if (checkdraw(board){ != false or checkwin(board){ != false)
    return true
  else
    return false
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method to check empty squares on the board
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function findemptysquares(board){
  
  emptysquares = []
  k = 0
  for i in 0..2
    for j in 0..2
      if (board[i][j].nil?)
        emptysquares[k] = [i,j]
        k += 1
      }
    }
  }
  return emptysquares
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that predicts a lose state
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function computerpredictloss(board, val)
  // Change the val
  if (val == 0)
    val = 1
  elsif val == 1
    val = 0
  }

  // Check for an empty square
  tmpboard = Array.new
  tmpboard[0] = board[0].dup
  tmpboard[1] = board[1].dup
  tmpboard[2] = board[2].dup
  showsimpboard(tmpboard){
  emptysquares = findemptysquares(board){
  print emptysquares
  print "\n"
  for i in 0..emptysquares.length-1
    print "\nChecking potential loss at square: "
    print emptysquares[i]
    tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
    showsimpboard(tmpboard){
    if (checkwin(tmpboard){!=false)
      print "\nLoss found\n"
      return emptysquares[i]
    }
    tmpboard = Array.new
    tmpboard[0] = board[0].dup
    tmpboard[1] = board[1].dup
    tmpboard[2] = board[2].dup
  }

  return -1
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that predicts a win state
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function computerpredictwin(board, val)
  // Check for an empty square
  tmpboard = Array.new
  tmpboard[0] = board[0].dup
  tmpboard[1] = board[1].dup
  tmpboard[2] = board[2].dup
  showsimpboard(tmpboard){
  emptysquares = findemptysquares(board){
  print emptysquares
  print "\n"
  for i in 0..emptysquares.length-1
    print "\nChecking potential win at square: "
    print emptysquares[i]
    tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
    showsimpboard(tmpboard){
    if (checkwin(tmpboard){!=false)
      print "\nWin found\n"
      return emptysquares[i]
    }
    tmpboard = Array.new
    tmpboard[0] = board[0].dup
    tmpboard[1] = board[1].dup
    tmpboard[2] = board[2].dup
  }

  return -1
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that spits out a computer response
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function computerresponse(board, val)
  // Check for an empty square
  emptysquares = findemptysquares(board){

  // Random value
  randsquare = (rand()*(emptysquares.length)).floor()

  predictloss = computerpredictloss(board, val)
  predictwin = computerpredictwin(board, val)
  if (predictwin != -1)
    return predictwin
  }
  if predictloss != -1
    return predictloss
  }
  return emptysquares[randsquare]
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that shows "Help" feature
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function showhelp()
  puts "\t\tEnter the following text commands: A1, A2, A3, B1, B2, B3, C1, C2, C3.\n\n\t\tThey correspond to each cell on the board..."
  puts "\n\t\t\"D\" displays the board and \"H\" displays Help"
  puts "\n\t\tPress Ctrl + C to exit the game at any time"
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that converts string commands to array indexes that
// refer to positions on the board
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function commandparser(command, board){

  commands = Array.new
  case command[0]
    when "A"
      commands[0] = 0
    when "B"
      commands[0] = 1
    when "C"
      commands[0] = 2
    when "D"
      showboard(board){
      commands[1] = -2
      return commands
    when "H"
      showhelp()
      commands[1] = -2
      return commands      
    else
      commands[0] = -1
  }

  case command[1]
    when "1"
      commands[1] = 0
    when "2"
      commands[1] = 1
    when "3"
      commands[1] = 2
    else
      commands[1] = -1
  }

  return commands
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that converts board array values commands to grid display indices
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function arraytodisplayparser(command)
  commands = Array.new
  
  if (command[0] < 3)
    commands[0] = (command[0] + 1)*2
  else
    commands[0] = -1
  }

  if (command[1] < 3)
    commands[1] = ((command[1]+1)*4)+1
  else
    commands[1] = -1
  }  

  return commands
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that converts board array values commands to grid display indices
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function arraytocommands(command)
  commands = Array.new
  case command[0]
    when 0
      commands[0] = "A"
    when 1
      commands[0] = "B"
    when 2
      commands[0] = "C"
  }

  case command[1]
    when 0
      commands[1] = "1"
    when 1
      commands[1] = "2"
    when 2
      commands[1] = "3"
  }
  return commands
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A method that converts commands to display indices
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function displayparser(command)
  commands = Array.new
  case command[0]
    when "A"
      commands[0] = 2
    when "B"
      commands[0] = 4
    when "C"
      commands[0] = 6
    else
      commands[0] = -1
  }

  case command[1]
    when "1"
      commands[1] = 5
    when "2"
      commands[1] = 9
    when "3"
      commands[1] = 13
    else
      commands[1] = -1
  }
  return commands
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// START THE GAME
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Initialise an empty board
board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]

// 1 player
// Create the board display
board_display = ["     1   2   3  ",
                 "   |---|---|---|",
                 " A |   |   |   |",
                 "   |---|---|---|",
                 " B |   |   |   |",
                 "   |---|---|---|",
                 " C |   |   |   |",
                 "   |---|---|---|"]

// Title Screen
puts "\n\n\n\t\t*****************************************************************************"
puts "\t\t*                                                                           *"
puts "\t\t*             Welcome to Tic-Tac-Toe Version 1.0 by Punit Dh                *"
puts "\t\t*                                                                           *"
puts "\t\t*****************************************************************************\n\n\n\n"
for i in 0..7
  puts "\t\t\t\t\t\t" + board_display[i]
}
print "\n\n\n\n\t\t\t\t\tPress ENTER or RETURN to continue"
tmp = gets

print "\n\n\t\tWelcome to Tic-Tac-Toe...\n\n\t\tYou can player in either 1-player or 2-player mode..."
tmp = gets

print "\n\n\t\t\'X\' always goes first..."
tmp = gets

print "\n\n\t\tWho gets \'X\' and who gets \'O\' is determined by a coin toss..."
tmp = gets

print "\n\n\t\tYou play by giving the following text commands: A1, A2, A3, B1, B2, B3, C1, C2, C3.\n\n\t\tThey correspond to each cell on the board..."
tmp = gets

print "\n\t\tYou can enter the text command \"D\" to display the board,\n\t\tor the text command \"H\" for Help if you get stuck..."
tmp = gets

print "\n\t\tPress Ctrl+C or Cmd+C to exit at any time..."
tmp = gets

print "\n\n\t\tLet's get started..."
tmp = gets

// Choose One-Player or Two-Player Mode
playermode = -1
until (playermode == 1 or playermode == 2)
  print "\n\t\tChoose (1)-player or (2)-player mode: "
  playermodeget = gets.chomp
  playermode = playermodeget.to_i
  if (playermode < 1 or playermode > 2)
    puts "\n\t\t\"//{playermodeget}\" is not a valid player mode. Enter 1 or 2.\n"
  }
}

// Initialise player
player1 = {player: 1, name: "Player 1", val: -1, str: ""}
player2 = {player: 2, name: "Player 2", val: -1, str: ""}

print "\n\t\tEnter //{player1[:name]} Name: "
player1[:name] = gets.chomp

if (playermode == 2)
  print "\n\t\tEnter //{player2[:name]} Name: "
  player2[:name] = gets.chomp
elsif playermode == 1
  player2[:name] = "Computer"
}

if playermode == 1
  print "\n\n\t\tWelcome //{player1[:name]}!"
elsif playermode == 2
  print "\n\n\t\tWelcome //{player1[:name]} and //{player2[:name]}!"
}
tmp = gets

print "\n\n\n\t\tTossing coin now..."
tmp = gets

// Randomly select a person to be first player: The "X" player
player1[:val] = (rand()*2)

if (player1[:val] < 1)
  cointoss = "T"
else
  cointoss = "H"
}

puts "\n\t\tThe result of the coin toss is: \n\n"
puts "\t\t\t\t\t\t\t  -------  "
puts "\t\t\t\t\t\t\t/         \\"
puts "\t\t\t\t\t\t\t|    //{cointoss}    |"
puts "\t\t\t\t\t\t\t\\         /"
print "\t\t\t\t\t\t\t  -------- "


// puts player1[:val]

if (player1[:val] <= 1)
  player1[:str] = "O"
  player1[:val] = 0  // The 0 represents 1
  player2[:str] = "X"
  player2[:val] = 1  // The 1 represents X 
else
  player1[:str] = "X"
  player1[:val] = 1  // The 1 represents X
  player2[:str] = "O"
  player2[:val] = 0  // The 0 represents O
}

tmp = gets

if player2[:val] == 1
  currentplayer = player2
elsif player1[:val] == 1
  currentplayer = player1
}

puts "\n\t\t//{player1[:name]} is \'//{player1[:str]}\'. //{player2[:name]} is \'//{player2[:str]}\'.\n\n"

// Determining who goes first
print "\t\t//{currentplayer[:name]} goes first"
tmp = gets

// Set current player to player 1
// currentplayer = player1

if playermode == 1 and currentplayer[:name] == "Computer"
  print "\n\n\t\tComputer's first move: "
  computer_response = computerresponse(board, currentplayer[:val])
  computer_response_command = arraytocommands(computer_response)
  print "\"//{computer_response_command.join()}\"\n"
  computer_response_display = arraytodisplayparser(computer_response)
  board[computer_response[0]][computer_response[1]] = currentplayer[:val]
  board_display[computer_response_display[0]][computer_response_display[1]] = currentplayer[:str]
  // currentplayer = player2

  // Change turn
  if currentplayer == player1
    currentplayer = player2
  elsif currentplayer == player2
    currentplayer = player1
  }

}

// Show the board for the first time
showboard(board_display)

// Game loop
while (checkwin(board){ == false and checkdraw(board){ == false)

  print "\n\t\t//{currentplayer[:name]}, please enter a command: "
  command = gets.chomp
  puts "\n\t\tYou entered: \"//{command}\""
  
  command_parse = commandparser(command, board_display)
  row_select = command_parse[0]
  column_select = command_parse[1]

  display_parse = displayparser(command)
  row_select_display = display_parse[0]
  column_select_display = display_parse[1]

  if column_select == -2
    next
  }

  if (row_select == -1 or column_select == -1)
    puts "\n\t\t\"//{command}\" is not a valid command."
    //puts "Please enter \"A1\",\"A2\",\"A3\",\"B1\",\"B2\"...etc."
  else
    if (board[row_select][column_select].nil?)
      board[row_select][column_select] = currentplayer[:val]
      board_display[row_select_display][column_select_display] = currentplayer[:str]
      
      if (checkgameover(board){)
        break
      }

      if (playermode == 1)
        currentplayer = player2
        print "\n\t\tComputer responds: "
        computer_response = computerresponse(board, currentplayer[:val])
        computer_response_command = arraytocommands(computer_response)
        print "\"//{computer_response_command.join()}\"\n"
        computer_response_display = arraytodisplayparser(computer_response)
        board[computer_response[0]][computer_response[1]] = currentplayer[:val]
        board_display[computer_response_display[0]][computer_response_display[1]] = currentplayer[:str]
      }

      showboard(board_display)
      if (checkgameover(board){)
        break
      }

      // Change turn
      if currentplayer == player1
        currentplayer = player2
      elsif currentplayer == player2
        currentplayer = player1
      }

    else
      puts "\n\t\t\"//{command}\" is not an empty space"
    }
  }
}


// showboard(board_display)
puts ""

if (checkwin(board){!=false)
  winner = checkwin(board){
  if player1[:val] == winner
    winnername = player1[:name]
  elsif player2[:val] == winner
    winnername = player2[:name]
  }
  puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
  puts "\t\t\t\t\t|     //{winnername} won!      |"
  puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
elsif (checkdraw(board){!=false)
  puts "\t\t\t\t\t|-----------------|"
  puts "\t\t\t\t\t| Game is a draw! |"
  puts "\t\t\t\t\t|-----------------|"
}

puts ""