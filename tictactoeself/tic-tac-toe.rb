require "./game_end.rb"
require "./init.rb"
require "./parser.rb"
require "./artificial-intelligence.rb"
require "./game-play.rb"
#require "pry"

####################################################################################
###############################                      ###############################
##########################         START THE GAME         ##########################
###############################                      ###############################
####################################################################################

# Initialise
board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
moverecord = Array.new
board_display = displayboard()

# Show title screen and get player info
showtitlescreen()
playermode = chooseplayermode()
player = getplayernames(playermode)
currentplayer = cointoss(player)
game = {"board": board, "playermode": playermode, "player": player, "currentplayer": currentplayer, "moverecord": moverecord, "commands": commands, "board_display": board_display}

if playermode == 1 and currentplayer[:name] == "Computer"
  computermove(board, currentplayer, moverecord, commands, board_display)
  currentplayer = swapturn(currentplayer, player)
end

showboard(board_display)

# Game loop
begin
  print "\n\t\t#{currentplayer[:name]}, please enter a command: "
  command = gets.chomp.upcase
  puts "\n\t\tYou (#{currentplayer[:str]}) entered: \"#{command}\""
  
  # command = validatecommand(game, command)
  
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
        computermove(board, currentplayer, moverecord, commands, board_display)
      end
      if (checkgameover(board))
        break
      end
      showboard(board_display)
      print (playermode == 1) ? "\n\t\tPerformed #{$foo} iterations...\n" : nil
      currentplayer = swapturn(currentplayer, player)

    else
      puts "\n\t\t\"#{command}\" is not an empty space"
    end
  end
end while not (checkgameover(board))

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

  if playermode == 1
    showboard(board_display)
    puts ""
    puts "\t\t\t\t\t|-------------------------|"
    puts "\t\t\t\t\t|        You lose!        |"
    puts "\t\t\t\t\t|-------------------------|"
  else
    showboard(board_display)
    puts ""
    puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
    puts "\t\t\t\t\t|     #{winnername} won!      |"
    puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
  end
elsif (checkdraw(board))
  showboard(board_display)
  puts ""
  puts "\t\t\t\t\t|-----------------|"
  puts "\t\t\t\t\t| Game is a draw! |"
  puts "\t\t\t\t\t|-----------------|"
end

puts ""