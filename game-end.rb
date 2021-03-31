#############################################################################
# A method that ends the game
#############################################################################
def endgame(game)
  
  
  winner = checkwin(game.board)
  puts "\n\n"
  if (winner)
    winnername = Player.find(winner)
    game.moverecord.push(winnername.name)

    if game.playermode == 1
      puts "\t\t\t\t\t|-------------------------|"
      puts "\t\t\t\t\t|        You lose!        |"
      puts "\t\t\t\t\t|-------------------------|"
    else
      puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
      puts "\t\t\t\t\t|     #{winnername} won!      |"
      puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
    end
  elsif (checkdraw(game.board))
    puts "\t\t\t\t\t|-------------------------|"
    puts "\t\t\t\t\t|     Game is a draw!     |"
    puts "\t\t\t\t\t|-------------------------|"

    game.moverecord.push("Draw")
  end
  puts "\n\n\t\tResults automatically saved to ./gameresults.txt\n\n\n"
  File.write('./gameresults.txt', game.moverecord.to_s + "\n", mode: 'a')
end

#############################################################################
# A method to check win states and returns the winner
#############################################################################
def checkwin(board)
  tmparray = Array.new
  tmparray[0] = Array.new
  tmparray[1] = Array.new

  board.map.with_index do |row,i|
    return board.transpose[i].first if checkequal(board.transpose[i])
    return board[i].first if checkequal(board[i])
    tmparray[0].push(board[i][i])
    tmparray[1].push(board[2-i][i])
  end

  return tmparray[0][0] if checkequal(tmparray.first)
  return tmparray[1][0] if checkequal(tmparray[1])
  return false
end

#############################################################################
# A method to check if all elements in an array are equal
#############################################################################
def checkequal(array)
   return (array.compact.length == array.length and array.uniq.length == 1) #? array.uniq[0] : false
end
  
  #############################################################################
  # A method to check draw states
  #############################################################################
  def checkdraw(board)
    return (board.flatten.compact.length == 9)
  end
  
  #############################################################################
  # A method to check game over status
  #############################################################################
  def checkgameover(game)
    (checkdraw(game.board) or checkwin(game.board))
  end