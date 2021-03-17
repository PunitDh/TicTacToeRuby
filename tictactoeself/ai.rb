#############################################################################
# A method to check empty squares on the board
#############################################################################
def checkemptysquares(board)
  
    emptysquares = []
    k = 0
    for i in 0..2
      for j in 0..2
        if (board[i][j].nil?)
          emptysquares[k] = [i,j]
          k += 1
        end
      end
    end
    return emptysquares
  end
  
  # # #############################################################################
  # # # A method that predicts the next move DEBUG MODE ACTIVE
  # # #############################################################################
  # def computerpredictmove(board, val)
  #   # Check for an empty square
  #   tmpboard = Array.new
  #   emptysquares = checkemptysquares(board)
  #   print "\n\t\t"                                            #debug
  #   print emptysquares                                        #debug
  #   print "\n"                                                #debug
  #   for i in 0..emptysquares.length-1
  #     tmpboard[0] = board[0].dup
  #     tmpboard[1] = board[1].dup
  #     tmpboard[2] = board[2].dup
  #     print "\n\t\tChecking square: "                         #debug
  #     print emptysquares[i]                                   #debug
  #     tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
  #     showsimpleboard(tmpboard)                               #debug
  #     if (checkwin(tmpboard)!=false)
  #       print "\n\t\tGame end scenario found\n"               #debug
  #       return emptysquares[i]
  #     end
  #   end
  #   return -1
  # end
  
  
  
  # #############################################################################
  # # A method that predicts the next move NO DEBUG MODE
  # #############################################################################
  def computerpredictmove(board, val)
    tmpboard = Array.new
    emptysquares = checkemptysquares(board)
    for i in 0..emptysquares.length-1
  
      # Reset the temporary board
      tmpboard[0] = board[0].dup
      tmpboard[1] = board[1].dup
      tmpboard[2] = board[2].dup
  
      # Add a value to the board and see if it leads to a win
      tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
      if (checkwin(tmpboard))
        return emptysquares[i]
      end
    end
    return -1
  end
  
  
  #############################################################################
  # A method that spits out a computer response
  #############################################################################
  def computerresponse(board, val)
    # Check for an empty square
    emptysquares = checkemptysquares(board)
  
    # Random value
    randsquare = (rand()*(emptysquares.length)).floor()
  
    predictloss = computerpredictmove(board, swapturn(val))
    predictwin = computerpredictmove(board, val)
    if (predictwin != -1)
      return predictwin
    end
    if predictloss != -1
      return predictloss
    end
  
    #debug
    puts "\n\n\t\tGenerate random response..."
  
    return emptysquares[randsquare]
  end