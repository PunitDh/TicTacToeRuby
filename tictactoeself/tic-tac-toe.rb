require "./game_end.rb"
require "./print.rb"
require "./parser.rb"
require "./artificial-intelligence.rb"
require "pry"

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
player = Array.new
player[0] = {name: "Player 1", val: -1, str: ""}
player[1] = {name: "Player 2", val: -1, str: ""}

# Initialise move number
moverecord = Array.new

# Create the board display
board_display = ["     1   2   3  ",
                 "   |---|---|---|",
                 " A |   |   |   |",
                 "   |---|---|---|",
                 " B |   |   |   |",
                 "   |---|---|---|",
                 " C |   |   |   |",
                 "   |---|---|---|"]

showtitlescreen(board_display)


playermode = chooseplayermode()

player = getplayernames(playermode)

# Welcome the players
if playermode == 1
  print "\n\n\t\tWelcome #{player[0][:name]}!"
elsif playermode == 2
  print "\n\n\t\tWelcome #{player[0][:name]} and #{player[1][:name]}!"
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
  player[0][:str] = "O"
  player[0][:val] = 0  # The 0 represents 1
  player[1][:str] = "X"
  player[1][:val] = 1  # The 1 represents X   
else
  cointoss = "H"
  player[0][:str] = "X"
  player[0][:val] = 1  # The 1 represents X
  player[1][:str] = "O"
  player[1][:val] = 0  # The 0 represents O 
end

puts "\n\t\tThe result of the coin toss is: \n\n"
puts "\t\t\t\t\t\t\t  -------  "
puts "\t\t\t\t\t\t\t/         \\"
puts "\t\t\t\t\t\t\t|    #{cointoss}    |"
puts "\t\t\t\t\t\t\t\\         /"
print "\t\t\t\t\t\t\t  -------- "

tmp = gets

# Set current player based on who has X or O
if player[1][:val] == 1
  currentplayer = player[1]
elsif player[0][:val] == 1
  currentplayer = player[0]
end

puts "\n\t\t#{player[0][:name]} is \'#{player[0][:str]}\'. #{player[1][:name]} is \'#{player[1][:str]}\'.\n\n"

# Determining who goes first
print "\t\t#{currentplayer[:name]} goes first..."
tmp = gets

if playermode == 1 and currentplayer[:name] == "Computer"
  computermove(board, currentplayer[:val], currentplayer[:str], moverecord, commands, board_display)
  # Swap turns
  if currentplayer == player[0]
    currentplayer = player[1]
  elsif currentplayer == player[1]
    currentplayer = player[0]
  end
end

# Show the board for the first time
showboard(board_display)

# Game loop
begin 
  print "\n\t\t#{currentplayer[:name]}, please enter a command: "
  command = gets.chomp.upcase
  puts "\n\t\tYou (#{currentplayer[:str]}) entered: \"#{command}\""
  
  cmd_parse = commandparser(commands, board_display, command)
  display_parse = displayparser(commands, command)

  if cmd_parse[1] == -2
    next
  end

  if (cmd_parse[0] == -1 or cmd_parse[0] == -1)
    puts "\n\t\t\"#{command}\" is not a valid command. Enter \"H\" for help."
  else
    if (board[cmd_parse[0]][cmd_parse[1]].nil?)
      moverecord.push(cmd_parse)
      board[cmd_parse[0]][cmd_parse[1]] = currentplayer[:val]
      board_display[display_parse[0]][display_parse[1]] = currentplayer[:str]
      if (checkgameover(board))
        break
      end

      if (playermode == 1)
        currentplayer = player[1]
        computermove(board, currentplayer[:val], currentplayer[:str], moverecord, commands, board_display)
      end
      if (checkgameover(board))
        break
      end
      # Show board display
      showboard(board_display)
      print "\n\t\tPerformed #{$foo} iterations...\n"
      # Swap turns
      if currentplayer == player[0]
        currentplayer = player[1]
      elsif currentplayer == player[1]
        currentplayer = player[0]
      end

    else
      puts "\n\t\t\"#{command}\" is not an empty space"
    end
  end
end while !(checkgameover(board))

# Game end state
File.write('./gameresults.txt', moverecord.to_s + "\n", mode: 'a')
puts ""
winner = checkwin(board)
if (winner)
  if player[0][:val] == winner
    winnername = player[0][:name]
  elsif player[1][:val] == winner
    winnername = player[1][:name]
  end
  showboard(board_display)
  puts ""
  puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
  puts "\t\t\t\t\t|     #{winnername} won!      |"
  puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
elsif (checkdraw(board))
  showboard(board_display)
  puts ""
  puts "\t\t\t\t\t|-----------------|"
  puts "\t\t\t\t\t| Game is a draw! |"
  puts "\t\t\t\t\t|-----------------|"
end

puts ""