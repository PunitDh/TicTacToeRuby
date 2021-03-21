#############################################################################
# A method to check win states and returns the winner
#############################################################################
def checkwin(board)

  # All win states:
    # Row A, Row B, Row C
    # Column 1, Column 2, Column 3
    # Diagonal A1, B2, C3
    # Diagonal C1, B2, A3

  tmparray = Array.new
  tmparray[0] = Array.new
  tmparray[1] = Array.new

  for i in 0..2
    # Check each column
    if (checkequal(board.transpose[i]))
        return board.transpose[i][0]
    end

    # Check each row
    if (checkequal(board[i]))
        return board[i][0]
    end

    # Diagonal A1, B2, C3
    tmparray[0].push(board[i][i])

    # Diagonal C1, B2, A3
    tmparray[1].push(board[2-i][i])
  end
  
  if (checkequal(tmparray[0]))  # Diagonal A1, B2, C3
    return tmparray[0][0]
  elsif (checkequal(tmparray[1]))  # Diagonal C1, B2, A3
    return tmparray[1][0]
  end

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
    return (findemptysquares(board).length == 0)
  end
  
  #############################################################################
  # A method to check game over status
  #############################################################################
  def checkgameover(board)
    (checkdraw(board) or checkwin(board))
  end
