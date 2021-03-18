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

#############################################################################
# A method to draw the board
#############################################################################
def swapturn(val)
  return (val-1).abs
end

# #############################################################################
# # A method that predicts the next move NO DEBUG MODE
# #############################################################################
def computerpredictmoves(board, val)
  tmpboard = Array.new
  emptysquares = checkemptysquares(board)
  movevalue = Array.new
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
  
def checkfork(board)
  return checkcornerfork(board)
end

def checkcornerfork(board)
  b = board
  c = [
        # Corner Forks
        [ [0,0],[0,1],[1,0], [0,2], [2,0] ],
        [ [0,1],[0,2],[1,2], [0,0], [2,2] ],
        [ [1,2],[2,1],[2,2], [0,2], [2,0] ],
        [ [1,0],[2,0],[2,1], [0,0], [2,2] ],

        # Cross Forks
        [ [0,2],[2,2],[1,1], [0,0], [2,0] ],
        [ [2,0],[2,2],[1,1], [0,0], [0,2] ],
        [ [0,0],[2,0],[1,1], [0,0], [2,2] ],
        [ [0,0],[0,2],[1,1], [2,0], [2,2] ],

        # Center Slant Forks 
        [ [0,1],[1,0],[1,1], [1,2], [2,1] ],
        [ [0,1],[1,2],[1,1], [1,0], [2,1] ],
        [ [1,2],[2,1],[1,1], [0,1], [1,0] ],
        [ [1,0],[2,1],[1,1], [0,1], [1,2] ],

        # Tridents 
        [ [0,0],[0,2],[2,2], [1,1], [1,2] ],
        [ [0,0],[0,2],[2,2], [0,1], [1,2] ],
        [ [0,0],[0,2],[2,2], [0,1], [1,1] ],
        [ [0,2],[2,0],[2,2], [1,1], [1,2] ],
        [ [0,2],[2,0],[2,2], [1,1], [2,1] ],
        [ [0,2],[2,0],[2,2], [1,2], [2,1] ],
        [ [0,0],[2,0],[2,2], [1,0], [2,1] ],
        [ [0,0],[2,0],[2,2], [1,1], [2,1] ],
        [ [0,0],[2,0],[2,2], [1,0], [1,1] ],
        [ [0,0],[0,2],[2,0], [0,1], [1,0] ],
        [ [0,0],[0,2],[2,0], [1,0], [1,1] ],
        [ [0,0],[0,2],[2,0], [0,1], [1,1] ],

        # Center Adjacent Forks ############ GO FROM HERE
        [ [0,0],[1,0],[1,1], [1,2], [2,0] ],
        [ [0,0],[1,0],[1,1], [2,0], [2,2] ],
        [ [0,0],[1,0],[1,1], [1,2], [2,2] ],
        [ [1,0],[2,0],[1,1], [0,0], [1,2] ],
        [ [1,0],[2,0],[1,1], [0,0], [0,2] ],
        [ [1,0],[2,0],[1,1], [0,2], [1,2] ],
        [ [2,0],[2,1],[1,1], [0,1], [2,2] ],
        [ [2,0],[2,1],[1,1], [0,2], [2,2] ],
        [ [2,0],[2,1],[1,1], [0,1], [0,2] ],
        [ [2,1],[2,2],[1,1], [0,1], [2,0] ],
        [ [2,1],[2,2],[1,1], [0,0], [2,0] ],
        [ [2,1],[2,2],[1,1], [0,0], [0,1] ],
        [ [1,2],[2,2],[1,1], [0,2], [1,0] ],
        [ [1,2],[2,2],[1,1], [0,0], [0,2] ],
        [ [1,2],[2,2],[1,1], [0,0], [1,0] ],
        [ [0,2],[1,2],[1,1], [1,0], [2,2] ],
        [ [0,2],[1,2],[1,1], [0,2], [2,2] ],
        [ [0,2],[1,2],[1,1], [1,0], [2,0] ],
        [ [0,1],[0,2],[1,1], [0,0], [2,1] ],
        [ [0,1],[0,2],[1,1], [0,0], [2,0] ],
        [ [0,1],[0,2],[1,1], [2,0], [2,1] ],
        [ [0,0],[0,1],[1,1], [0,2], [2,1] ],
        [ [0,0],[0,1],[1,1], [0,0], [2,2] ],
        [ [0,0],[0,1],[1,1], [2,1], [2,2] ]
      ]
  
  for i in 0..c.length-1
    d = c[i]
    f = Array.new
    for j in 0..2
      f.push(b[d[j][0]][d[j][1]])
    end
    if (areequal(f))
      if (b[d[3][0]][d[3][1]].nil? and b[d[4][0]][d[4][1]].nil?)
        return true
      end
    end
  end
  return false
end

def checkcentercrossfork(board)

end

def checkcenterslantfork(board)

end

def  checkcenteradjacentfork(board)

end

def checktrident(board)

end

def arraydup(arr)
  b = Arr.new
  for i in 0..arr.length-1
    b[i] = arr[i].dup
  end
  return b
end

  # def test3combinations(testval, val)
  #   arr = Array.new
  #   arr.push(val[0] == testval and val[1] == testval)
  #   arr.push(val[1] == testval and val[2] == testval)
  #   arr.push(val[0] == testval and val[2] == testval)
  #   return arr
  # end

  # def testnilcombinations(val)
  #   arr = Array.new
  #   arr.push(val[0].nil? and val[1].nil?)
  #   arr.push(val[1].nil? and val[2].nil?)
  #   arr.push(val[0].nil? and val[2].nil?)
  #   return arr
  # end

def areequal(val)
  if (val.compact.length != 0)
    return (val.uniq.length == 1)
  end
end
  
  # #############################################################################
  # # A method that predicts the next move NO DEBUG MODE
  # #############################################################################
  # def computerpredictmove(board, val)
  #   tmpboard = Array.new
  #   emptysquares = checkemptysquares(board)
  #   possiblemoves = Array.new

  #   for i in 0..emptysquares.length-1
  
  #     # Reset the temporary board
  #     tmpboard[0] = board[0].dup
  #     tmpboard[1] = board[1].dup
  #     tmpboard[2] = board[2].dup
  
  #     # Add a value to the board and see if it leads to a win
  #     tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
  #     if (checkwin(tmpboard))
  #       return emptysquares[i]
  #     end

  #     # if (checkfork(tmpboard))
  #     #   possiblemoves.push(emptysquares[i])
  #     # end

  #   end
  #   return -1
  # end

  # #############################################################################
# # A method that predicts the next move DEBUG MODE ACTIVE
# #############################################################################
def computerpredictmove(board, val)
  # Check for an empty square
  tmpboard = Array.new
  emptysquares = checkemptysquares(board)
  print "\n\t\t"                                            #debug
  print emptysquares                                        #debug
  print "\n"                                                #debug
  for i in 0..emptysquares.length-1
    tmpboard[0] = board[0].dup
    tmpboard[1] = board[1].dup
    tmpboard[2] = board[2].dup
    print "\n\t\tChecking square: "                         #debug
    print emptysquares[i]                                   #debug
    tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
    showsimpleboard(tmpboard)                               #debug

    if (checkwin(tmpboard)!=false)
      print "\n\t\tGame end scenario found\n"               #debug
      return emptysquares[i]
    # elsif checkfork(tmpboard)!=false
    #   print "\n\t\tPossible fork found\n"
    #   return emptysquares[i]
    end
  end
  return -1
end


#############################################################################
# A method that predicts the board 'n' moves ahead
#############################################################################
def computerpredictboard(board, val, n=1)
  tmpboard = Array.new
  tmpboard[0] = board[0].dup
  tmpboard[1] = board[1].dup
  tmpboard[2] = board[2].dup
  emptysquares = checkemptysquares(tmpboard)

  for i in 0..emptysquares.length-1
    tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
    if (checkwin(tmpboard)!=false)
      return emptysquares[i]
    end

    val = swapturn(val)
    emptysquares = checkemptysquares(tmpboard)
    for j in 0..emptysquares.length-1
      tmpboard[emptysquares[j][0]][emptysquares[j][1]] = val
      if (checkwin(tmpboard)!=false)
        return emptysquares[j]
      end
    end



  end
  

end

  

#############################################################################
# A method that spits out a computer response
#############################################################################
def computerresponse(board, val)
  # Check for an empty square
  emptysquares = checkemptysquares(board)

  # Random value
  bestsquare = (rand()*(emptysquares.length)).floor()

  
  
  predictwin = computerpredictmove(board, val)
  if (predictwin != -1)
    return predictwin
  end
  predictloss = computerpredictmove(board, swapturn(val))
  if predictloss != -1
    return predictloss
  end

  # predict best move
  
  #predictfork = checkfork(tmpboard))

  #debug
  puts "\n\n\t\tGenerate random response..."

  return emptysquares[bestsquare]
end