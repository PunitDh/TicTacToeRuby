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
  # for z in 0..n-1
  #   tmpboard[z] = Array.new
  # end
  tmpboard[0] = Array.new
  tmpboard[1] = Array.new
  bestmovesself = Array.new
  bestmovesopponent = Array.new

  emptysquares = checkemptysquares(board)
  for i in 0..emptysquares.length-1
    tmpboard[0][0] = board[0].dup
    tmpboard[0][1] = board[1].dup
    tmpboard[0][2] = board[2].dup
    emptysquares = checkemptysquares(tmpboard[0])
    tmpboard[0][emptysquares[i][0]][emptysquares[i][1]] = val
    print "\n\t\tChecking square for computer: "             #debug
    print emptysquares[i]
    showsimpleboard(tmpboard[0])
    if (checkwin(tmpboard[0]))
      bestmovesself.push(emptysquares[i])
      puts "\t\tThis move will make me (the computer) win" ## But if I try anything else I will lose, right?
      # return emptysquares[i]
    end
    # if (checkwin(tmpboard[0],swapturn(val))) # Check potential loss
    #   bestmovesself.push(emptysquares[i])
    #   puts "\t\tThis is a potential loss for me (The computer)"
    # end
    if (checkblock(tmpboard[0], val))
      bestmovesself.push(emptysquares[i])
      puts "\t\tWith this I can block the opponent's win"
    end
    if (checkpotentialwin(tmpboard[0],val))
      bestmovesself.push(emptysquares[i])
      puts "\t\tThis is a good move for me (the computer)"
    end
    if (checkfork(tmpboard[0],val))
      bestmovesself.push(emptysquares[0])
      puts "\t\tWith this I can fork the opponent"
    end

    emptysquares1 = checkemptysquares(tmpboard[0])
    val = swapturn(val)
    for j in 0..emptysquares1.length-1
      tmpboard[1][0] = tmpboard[0][0].dup
      tmpboard[1][1] = tmpboard[0][1].dup
      tmpboard[1][2] = tmpboard[0][2].dup
      tmpboard[1][emptysquares1[j][0]][emptysquares1[j][1]] = val
      print "\n\t\tChecking square for opponent: "             #debug
      print emptysquares1[j]
      showsimpleboard(tmpboard[1])
      if (checkwin(tmpboard[1]))
        bestmovesopponent.push(emptysquares1[j])
        puts "\t\tThis will make the opponent (Player 1) win"
      end ## But if he tries anything else he will lose, right?
      if (checkblock(tmpboard[1], val))
        bestmovesopponent.push(emptysquares1[j])
        puts "\t\tThe opponent can block my win with this move"
      end
      if (checkpotentialwin(tmpboard[1],val))
        bestmovesopponent.push(emptysquares1[j])
        puts "\t\tThis is a good move for the opponent (Player 1)"
      end
      if (checkfork(tmpboard[1],val))
        bestmovesopponent.push(emptysquares1[j])
        puts "\t\tDanger! Potential opponent fork detected!"
      end
    end
    val = swapturn(val)
  end
  
  print "Best moves for the opponent:\n"
  print bestmovesopponent.uniq
  puts ""
  print "Best moves for the computer:\n"
  print bestmovesself
end

#############################################################################
# A method that checks if the move is a "fork" - a powerful move
#############################################################################
def checkfork(board, val)
  c = countinst(board, val)
  r = 0
  if (c >= 3)
    for i in 0..(c-1)
      f = replacenthindexof(board, val, nil, i)
      if (checkpotentialwin(f,val))
        r += 1
      end
    end
    return (r >= (c-1))
  end
  return false
end

#############################################################################
# A method that counts the number of instances of 'val' on the board
#############################################################################
def countinst(board, val)
  c = 0
  for i in 0..board.length-1
  c += board[i].count(val)
  end
  return c
end

#############################################################################
# A method that finds the index of 'val' on the board in x,y coordinates
#############################################################################
def findindexof(board, val)
  n = countinst(board, val)
  c = Array.new

  for i in 0..board.length-1
    for j in 0..board[i].length-1
      if board[i][j] == val
        tmp = [i,j]
        c.push(tmp)
      end
    end
  end
  return c
end

#########################################################################################
# A method that replaces n-th index of an occurence of 'val' on a board with 'replaceval'
#########################################################################################
def replacenthindexof(board, val, replaceval, n)
    tmpboard = Array.new
    for i in 0..board.length-1
      tmpboard[i] = board[i].dup
    end

    c = findindexof(tmpboard, val)
    tmpboard[c[n][0]][c[n][1]] = replaceval

    return tmpboard
end

#############################################################################
# A method that checks if the move is a "potential" win
#############################################################################
def checkpotentialwin(board, val)

  # All win states:
  # Row A, Row B, Row C
  # Column 1, Column 2, Column 3
  # A1, B2, C3
  # C1, B2, A3

  #board.map do ||
  #end
  tmparray = Array.new
  tmparray[0] = Array.new
  tmparray[1] = Array.new

  for i in 0..2
    # Check each column
    tmpboard = board.transpose
    if (tmpboard[i].uniq.length == 2 and tmpboard[i].compact.length == 2 and tmpboard[i].uniq.compact[0] == val)
      return true
    end

    # Check each row
    if (board[i].uniq.length == 2 and board[i].compact.length == 2 and board[i].uniq.compact[0] == val)
        return true
    end

    # Diagonal A1, B2, C3
    tmparray[0].push(board[i][i])

    # Diagonal C1, B2, A3
    tmparray[1].push(board[2-i][i])
  end
  
  if (tmparray[0].uniq.length == 2 and tmparray[0].compact.length == 2 and tmparray[0].uniq.compact[0] == val)  # Diagonal A1, B2, C3
    return true
  elsif (tmparray[1].uniq.length == 2 and tmparray[1].compact.length == 2 and tmparray[1].uniq.compact[0] == val)  # Diagonal C1, B2, A3
    return true
  end

  return false
end

def checkblock(board, val)
  # val is the value that I'm blocking
  # All win states:
  # Row A, Row B, Row C
  # Column 1, Column 2, Column 3
  # A1, B2, C3
  # C1, B2, A3

  #board.map do ||
  #end
  tmparray = Array.new
  tmparray[0] = Array.new
  tmparray[1] = Array.new

  for i in 0..2
    # Check each column
    tmpboard = board.transpose
    if (tmpboard[i].uniq.length == 2 and tmpboard[i].compact.length == 3 and tmpboard[i].count(val) < tmpboard[i].count(swapturn(val)))
      return true
    end

    # Check each row
    if (board[i].uniq.length == 2 and board[i].compact.length == 3 and tmpboard[i].count(val) < tmpboard[i].count(swapturn(val)))
        return true
    end

    # Diagonal A1, B2, C3
    tmparray[0].push(board[i][i])

    # Diagonal C1, B2, A3
    tmparray[1].push(board[2-i][i])
  end
  
  if (tmparray[0].uniq.length == 2 and tmparray[0].compact.length == 3 and tmpboard[i].count(val) > tmpboard[i].count(swapturn(val)))  # Diagonal A1, B2, C3
    return true
  elsif (tmparray[1].uniq.length == 2 and tmparray[1].compact.length == 3 and tmpboard[i].count(val) > tmpboard[i].count(swapturn(val)))  # Diagonal C1, B2, A3
    return true
  end

  return false
end

#############################################################################
# A method that spits out a computer response
#############################################################################
def computerresponse(board, val)
  # Check for an empty square
  emptysquares = checkemptysquares(board)

  # Random value
  bestsquare = (rand()*(emptysquares.length)).floor()

  computerpredictboard(board, val)
  
  # predictwin = computerpredictmove(board, val)
  # if (predictwin != -1)
  #   return predictwin
  # end
  # predictloss = computerpredictmove(board, swapturn(val))
  # if predictloss != -1
  #   return predictloss
  # end

  # predict best move
  
  #predictfork = checkfork(tmpboard))

  #debug
  puts "\n\n\t\tGenerate random response..."

  return emptysquares[bestsquare]
end












# THESE METHODS ARE NO LONGER NEEDED

# def checkfork(board) 
#   return checkcornerfork(board)
# end

# def checkcornerfork(board)
#   b = board
#   c = [
#         # Corner Forks
#         [ [0,0],[0,1],[1,0], [0,2], [2,0] ],
#         [ [0,1],[0,2],[1,2], [0,0], [2,2] ],
#         [ [1,2],[2,1],[2,2], [0,2], [2,0] ],
#         [ [1,0],[2,0],[2,1], [0,0], [2,2] ],

#         # Cross Forks
#         [ [0,2],[2,2],[1,1], [0,0], [2,0] ],
#         [ [2,0],[2,2],[1,1], [0,0], [0,2] ],
#         [ [0,0],[2,0],[1,1], [0,0], [2,2] ],
#         [ [0,0],[0,2],[1,1], [2,0], [2,2] ],

#         # Center Slant Forks 
#         [ [0,1],[1,0],[1,1], [1,2], [2,1] ],
#         [ [0,1],[1,2],[1,1], [1,0], [2,1] ],
#         [ [1,2],[2,1],[1,1], [0,1], [1,0] ],
#         [ [1,0],[2,1],[1,1], [0,1], [1,2] ],

#         # Tridents 
#         [ [0,0],[0,2],[2,2], [1,1], [1,2] ],
#         [ [0,0],[0,2],[2,2], [0,1], [1,2] ],
#         [ [0,0],[0,2],[2,2], [0,1], [1,1] ],
#         [ [0,2],[2,0],[2,2], [1,1], [1,2] ],
#         [ [0,2],[2,0],[2,2], [1,1], [2,1] ],
#         [ [0,2],[2,0],[2,2], [1,2], [2,1] ],
#         [ [0,0],[2,0],[2,2], [1,0], [2,1] ],
#         [ [0,0],[2,0],[2,2], [1,1], [2,1] ],
#         [ [0,0],[2,0],[2,2], [1,0], [1,1] ],
#         [ [0,0],[0,2],[2,0], [0,1], [1,0] ],
#         [ [0,0],[0,2],[2,0], [1,0], [1,1] ],
#         [ [0,0],[0,2],[2,0], [0,1], [1,1] ],

#         # Center Adjacent Forks ############ GO FROM HERE
#         [ [0,0],[1,0],[1,1], [1,2], [2,0] ],
#         [ [0,0],[1,0],[1,1], [2,0], [2,2] ],
#         [ [0,0],[1,0],[1,1], [1,2], [2,2] ],
#         [ [1,0],[2,0],[1,1], [0,0], [1,2] ],
#         [ [1,0],[2,0],[1,1], [0,0], [0,2] ],
#         [ [1,0],[2,0],[1,1], [0,2], [1,2] ],
#         [ [2,0],[2,1],[1,1], [0,1], [2,2] ],
#         [ [2,0],[2,1],[1,1], [0,2], [2,2] ],
#         [ [2,0],[2,1],[1,1], [0,1], [0,2] ],
#         [ [2,1],[2,2],[1,1], [0,1], [2,0] ],
#         [ [2,1],[2,2],[1,1], [0,0], [2,0] ],
#         [ [2,1],[2,2],[1,1], [0,0], [0,1] ],
#         [ [1,2],[2,2],[1,1], [0,2], [1,0] ],
#         [ [1,2],[2,2],[1,1], [0,0], [0,2] ],
#         [ [1,2],[2,2],[1,1], [0,0], [1,0] ],
#         [ [0,2],[1,2],[1,1], [1,0], [2,2] ],
#         [ [0,2],[1,2],[1,1], [0,2], [2,2] ],
#         [ [0,2],[1,2],[1,1], [1,0], [2,0] ],
#         [ [0,1],[0,2],[1,1], [0,0], [2,1] ],
#         [ [0,1],[0,2],[1,1], [0,0], [2,0] ],
#         [ [0,1],[0,2],[1,1], [2,0], [2,1] ],
#         [ [0,0],[0,1],[1,1], [0,2], [2,1] ],
#         [ [0,0],[0,1],[1,1], [0,0], [2,2] ],
#         [ [0,0],[0,1],[1,1], [2,1], [2,2] ]
#       ]
  
#   for i in 0..c.length-1
#     d = c[i]
#     f = Array.new
#     for j in 0..2
#       f.push(b[d[j][0]][d[j][1]])
#     end
#     if (areequal(f))
#       if (b[d[3][0]][d[3][1]].nil? and b[d[4][0]][d[4][1]].nil?)
#         return true
#       end
#     end
#   end
#   return false
# end

# def arraydup(arr)
#   b = Arr.new
#   for i in 0..arr.length-1
#     b[i] = arr[i].dup
#   end
#   return b
# end

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