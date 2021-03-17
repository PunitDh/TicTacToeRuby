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
  
    for i in 0..2
      # Check each column
      if !(board[0][i] or board[1][i] or board[2][i]).nil?
        if (board[0][i] == board[1][i] and board[1][i] == board[2][i] and board[2][i] == board[0][i])
          winner = board[0][i]
          return winner
        end
      end
  
      # Check each row
      if !(board[i][0] or board[i][1] or board[i][2]).nil?
        if (board[i][0] == board[i][1] and board[i][1] == board[i][2] and board[i][0] == board[i][2])
          winner = board[i][0]
          return winner
        end
      end
    end
  
      # Diagonal A1, B2, C3
      if (!(board[0][0] or board[1][1] or board[2][2]).nil? and (board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[0][0] == board[2][2]))
        winner = board[0][0]
        return winner
      end
  
      # Diagonal C1, B2, A3
      if (!(board[0][2] or board[1][1] or board[2][0]).nil? and (board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[0][2] == board[2][0]))
        winner = board[1][1]
        return winner
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