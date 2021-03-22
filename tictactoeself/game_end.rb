#############################################################################
# A method to check game over status
#############################################################################
def endgame(game)
  File.write('./gameresults.txt', game[:moverecord].to_s + "\n", mode: 'a')
  puts "\n"
  winner = checkwin(game[:board])
  if (winner)
    for w in game[:player]
      if !w.key(winner).nil?
        winnername = w[:name]
      end
    end
    if game[:playermode] == 1
      puts ""
      puts "\t\t\t\t\t|-------------------------|"
      puts "\t\t\t\t\t|        You lose!        |"
      puts "\t\t\t\t\t|-------------------------|"
    else
      puts ""
      puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
      puts "\t\t\t\t\t|     #{winnername} won!      |"
      puts "\t\t\t\t\t|-----" + "-"*(winnername.length+5) + "------|"
    end
  elsif (checkdraw(game[:board]))
    puts ""
    puts "\t\t\t\t\t|-----------------|"
    puts "\t\t\t\t\t| Game is a draw! |"
    puts "\t\t\t\t\t|-----------------|"
  end
  puts ""
end

#############################################################################
# A method to check win states and returns the winner
#############################################################################
def checkwin(board)
  tmparray = Array.new
  tmparray[0] = Array.new
  tmparray[1] = Array.new

  for i in 0..2
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
    (checkdraw(game[:board]) or checkwin(game[:board]))
  end


  # for i in 0..2
    
  #   # if (checkequal(board.transpose[i]))
  #   #     return board.transpose[i][0]
  #   # end
  #   # if (checkequal(board[i]))
  #   #   return board[i][0]
  #   # end

  #   # Check each column
  #   return board.transpose[i].first if checkequal(board.transpose[i])

  #   # Check each row
  #   return board[i].first if checkequal(board[i])
    
  #   # Diagonal A1, B2, C3
  #   tmparray[0].push(board[i][i])

  #   # Diagonal C1, B2, A3
  #   tmparray[1].push(board[2-i][i])
  # end

  #   # if (checkequal(tmparray[0]))
  # # Diagonal A1, B2, C3
  # return tmparray[0][0] if checkequal(tmparray.first)
  # # elsif (checkequal(tmparray[1]))
  # # Diagonal C1, B2, A3
  # return tmparray[1][0] if checkequal(tmparray[1])
  # # end

  # def checkwin(board)
  #   # All win states:
  #     # Row A, Row B, Row C
  #     # Column 1, Column 2, Column 3
  #     # Diagonal A1, B2, C3
  #     # Diagonal C1, B2, A3
  
  #   tmparray = Array.new
  #   tmparray[0] = Array.new
  #   tmparray[1] = Array.new
  
  #   for i in 0..2
  #     # Check each column
  #     return board.transpose[i].first if checkequal(board.transpose[i])
  
  #     # Check each row
  #     return board[i].first if checkequal(board[i])
  
  #     # Diagonal A1, B2, C3
  #     tmparray[0].push(board[i][i])
  
  #     # Diagonal C1, B2, A3
  #     tmparray[1].push(board[2-i][i])
  #   end
    
  #   # Diagonal A1, B2, C3
  #   return tmparray[0][0] if checkequal(tmparray.first)
  
  #   # Diagonal C1, B2, A3
  #   return tmparray[1][0] if checkequal(tmparray[1])
  
  #   return false
  # end