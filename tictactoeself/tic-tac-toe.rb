require "./game_end.rb"
require "./print.rb"
require "./parser.rb"
require "./ai.rb"

#############################################################################
#############################################################################
# START THE GAME
#############################################################################
#############################################################################

# Initialise an empty board
board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]

# Initialise commands
commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}

# Initialise players
player1 = {player: 1, name: "Player 1", val: -1, str: ""}
player2 = {player: 2, name: "Player 2", val: -1, str: ""}

# Create the board display
board_display = ["     1   2   3  ",
                 "   |---|---|---|",
                 " A |   |   |   |",
                 "   |---|---|---|",
                 " B |   |   |   |",
                 "   |---|---|---|",
                 " C |   |   |   |",
                 "   |---|---|---|"]

#board_display = ["     1   2   3  ",
#                 "   |---|---|---|",
#                 " A | " + board[0][0] + " | " + board[0][1] + " | " + board[0][2] + " | ",
#                 "   |---|---|---|",
#                 " B | " + board[1][0] + " | " + board[1][1] + " | " + board[1][2] + " | ",
#                 "   |---|---|---|",
#                 " C | " + board[2][0] + " | " + board[2][1] + " | " + board[2][2] + " | ",
#                 "   |---|---|---|"]

# board_display_head = ["     1   2   3  ", "   |---|---|---|",]
# rowheads = ["A", "B", "C"]


# board_display = board.map do |row|
#   display_row = row.map do |cell|
#       cell.nil? ? " " : cell
#   end

#   display_row.join(" | ")
# end

showtitlescreen(board_display)

# Choose One-Player or Two-Player Mode
playermode = -1
until (playermode == 1 or playermode == 2)
  print "\n\t\tChoose (1)-player or (2)-player mode: "
  playermodeget = gets.chomp
  playermode = playermodeget.to_i
  if (playermode < 1 or playermode > 2)
    puts "\n\t\t\"#{playermodeget}\" is not a valid player mode. Enter 1 or 2.\n"
  end
end

# Get player 1 name
print "\n\t\tEnter #{player1[:name]} Name: "
player1[:name] = gets.chomp

# If two-player mode, get second player's name, or else use "Computer"
if (playermode == 2)
  print "\n\t\tEnter #{player2[:name]} Name: "
  player2[:name] = gets.chomp
elsif playermode == 1
  player2[:name] = "Computer"
end

# Welcome the players
if playermode == 1
  print "\n\n\t\tWelcome #{player1[:name]}!"
elsif playermode == 2
  print "\n\n\t\tWelcome #{player1[:name]} and #{player2[:name]}!"
end
tmp = gets

# Coin toss
print "\n\n\n\t\tTossing coin now...(Press ENTER to see coin toss results)"
tmp = gets

# Generate a random value
randtoss = (rand()*2)

# Display the coin toss
if (randtoss < 1)
  cointoss = "T"
  player1[:str] = "O"
  player1[:val] = 0  # The 0 represents 1
  player2[:str] = "X"
  player2[:val] = 1  # The 1 represents X   
else
  cointoss = "H"
  player1[:str] = "X"
  player1[:val] = 1  # The 1 represents X
  player2[:str] = "O"
  player2[:val] = 0  # The 0 represents O 
end

puts "\n\t\tThe result of the coin toss is: \n\n"
puts "\t\t\t\t\t\t\t  -------  "
puts "\t\t\t\t\t\t\t/         \\"
puts "\t\t\t\t\t\t\t|    #{cointoss}    |"
puts "\t\t\t\t\t\t\t\\         /"
print "\t\t\t\t\t\t\t  -------- "

tmp = gets

# Set current player based on who has X or O
if player2[:val] == 1
  currentplayer = player2
elsif player1[:val] == 1
  currentplayer = player1
end

puts "\n\t\t#{player1[:name]} is \'#{player1[:str]}\'. #{player2[:name]} is \'#{player2[:str]}\'.\n\n"

# Determining who goes first
print "\t\t#{currentplayer[:name]} goes first..."
tmp = gets

if playermode == 1 and currentplayer[:name] == "Computer"
  computer_response = computerresponse(board, currentplayer[:val])
  computer_response_command = arraytocommandsparser(computer_response, commands)
  print "\n\n\t\tComputer's first move: "
  print "\"#{computer_response_command.join()}\"\n"
  computer_response_display = arraytodisplayparser(computer_response)
  board[computer_response[0]][computer_response[1]] = currentplayer[:val]
  board_display[computer_response_display[0]][computer_response_display[1]] = currentplayer[:str]

  # Swap turns
  if currentplayer == player1
    currentplayer = player2
  elsif currentplayer == player2
    currentplayer = player1
  end
end

# Show the board for the first time
showboard(board_display)

# Game loop
begin 
  print "\n\t\t#{currentplayer[:name]}, please enter a command: "
  command = gets.chomp
  puts "\n\t\tYou entered: \"#{command}\""
  
  cmd_parse = commandparser(commands, board_display, command)
  display_parse = displayparser(commands, command)

  if cmd_parse[1] == -2
    next
  end

  if (cmd_parse[0] == -1 or cmd_parse[0] == -1)
    puts "\n\t\t\"#{command}\" is not a valid command. Enter \"H\" for help"
  else
    if (board[cmd_parse[0]][cmd_parse[1]].nil?)
      board[cmd_parse[0]][cmd_parse[1]] = currentplayer[:val]
      board_display[display_parse[0]][display_parse[1]] = currentplayer[:str]
      showboard(board_display)
      if (checkgameend(board))
        break
      end

      if (playermode == 1)
        currentplayer = player2
        computer_response = computerresponse(board, currentplayer[:val])
        computer_response_command = arraytocommandsparser(computer_response, commands)
        print "\n\t\tComputer responds: "
        print "\"#{computer_response_command.join()}\"\n"
        computer_response_display = arraytodisplayparser(computer_response)
        board[computer_response[0]][computer_response[1]] = currentplayer[:val]
        board_display[computer_response_display[0]][computer_response_display[1]] = currentplayer[:str]
        
      end
      if (checkgameend(board))
        break
      end
      showboard(board_display)
      
      # Swap turns
      if currentplayer == player1
        currentplayer = player2
      elsif currentplayer == player2
        currentplayer = player1
      end

    else
      puts "\n\t\t\"#{command}\" is not an empty space"
    end
  end
end while (checkwin(board) == false and checkdraw(board) == false)

# Game end state
puts ""
winner = checkwin(board)
if (winner!=false)
  if player1[:val] == winner
    winnername = player1[:name]
  elsif player2[:val] == winner
    winnername = player2[:name]
  end
  showboard(board_display)
  puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
  puts "\t\t\t\t\t|     #{winnername} won!      |"
  puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
elsif (checkdraw(board)!=false)
  showboard(board_display)
  puts "\t\t\t\t\t|-----------------|"
  puts "\t\t\t\t\t| Game is a draw! |"
  puts "\t\t\t\t\t|-----------------|"
end

puts ""