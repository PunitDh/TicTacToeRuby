#############################################################################
# A method to check win states
#############################################################################
def checkwin(board)

  # All win states:
  # Row A, Row B, Row C
  # Column 1, Column 2, Column 3
  # A1, B2, C3
  # C1, B2, A3

  #board.map do ||
  #end
  tmparray = Array.new

  for i in 0..2
    # Check each column
    tmpboard = board.transpose
    if (tmpboard[i].compact.length > 0 and tmpboard[i].uniq.length == 1)
        return tmpboard[i][0]
    end

    # Check each row
    if (board[i].compact.length > 0 and board[i].uniq.length == 1)
        return board[i][0]
    end

    # Diagonal A1, B2, C3
    tmparray[0].push(board[i][i])

    # Diagonal C1, B2, A3
    tmparray[1].push(board[2-i][i])
  end

    # Diagonal A1, B2, C3
    tmparray[0] = Array.new
    for i in 0..2
      tmparray[0].push(board[i][i])
    end
    if (tmparray[0].compact.length > 0 and tmparray[0].uniq.length == 1)
      return tmparray[0][0]
    end

    # Diagonal C1, B2, A3
    tmparray[1] = Array.new
    for i in 0..2
      tmparray[1].push(board[2-i][i])
    end
    if (tmparray[1].compact.length > 0 and tmparray[1].uniq.length == 1)
      return tmparray[1][0]
    end

  return false
end
  
  #############################################################################
  # A method to check draw states
  #############################################################################
  def checkdraw(board)
    for i in 0..2
      for j in 0..2
        if board[i][j]==nil
          return false
        end
      end
    end
    return true
  end
  
  #############################################################################
  # A method to check game end status
  #############################################################################
  def checkgameend(board)
    (checkdraw(board) or checkwin(board))
  end
