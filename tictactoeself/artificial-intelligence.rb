################################################################################################
# A method that spits out a computer response
################################################################################################
def computerresponse(board, val)

  # Check for an empty square
  emptysquares = checkemptysquares(board)

  # Random value
  if (emptysquares.length == 9)
     bestsquare = (rand()*(emptysquares.length)).floor()
  else
    predictwin = computerpredictmove(board, val)
    if (predictwin != -1)
      return predictwin
    end

    predictloss = computerpredictmove(board, swapturn(val))
    if predictloss != -1
      return predictloss
    end

    # qq = computerpredictbestmove(board, val)
    # r = (rand()*(qq.length)).floor() 
    # bestsquare = qq[r]
    # bestsquare = emptysquares.index(bestsquare)

    bestsquare = computerpredictbestmove(board, val)
    bestsquare = emptysquares.index(bestsquare)
  end

  return emptysquares[bestsquare]
end

################################################################################################
# A method that predicts the board - NO DEBUG MODE
################################################################################################
def computerpredictbestmove(board, val, n=1)
  tmpboard = Array.new
  tmpboard[0] = Array.new
  tmpboard[1] = Array.new
  tmpboard[2] = Array.new
  emptysquares = Array.new
  best_moves = Array.new
  ok_moves = Array.new
  bad_moves = Array.new

  emptysquares[0] = checkemptysquares(board)
  for i in 0..emptysquares[0].length-1
    tmpboard[0][0] = board[0].dup
    tmpboard[0][1] = board[1].dup
    tmpboard[0][2] = board[2].dup
    emptysquares[0] = checkemptysquares(tmpboard[0])
    tmpboard[0][emptysquares[0][i][0]][emptysquares[0][i][1]] = val

    if (checkfork(tmpboard[0],val))
      best_moves.push(emptysquares[0][i])
    end

    if (checkpotentialwin(tmpboard[0],val))
      ok_moves.push(emptysquares[0][i])
    end

    emptysquares[1] = checkemptysquares(tmpboard[0])
    for j in 0..emptysquares[1].length-1
      tmpboard[1][0] = tmpboard[0][0].dup
      tmpboard[1][1] = tmpboard[0][1].dup
      tmpboard[1][2] = tmpboard[0][2].dup
      tmpboard[1][emptysquares[1][j][0]][emptysquares[1][j][1]] = swapturn(val)

      predictloss = checkwin(tmpboard[1])
      if (predictloss==swapturn(val))
        bad_moves.push(emptysquares[0][i])
      end

      if (checkfork(tmpboard[1],swapturn(val)))
        puts "\n\n\t\tFORK DETECTED:\n\n\t\t"
        bad_moves.push(emptysquares[0][i])
      end

      emptysquares[2] = checkemptysquares(tmpboard[1])
      for k in 0..emptysquares[2].length-1
        tmpboard[2][0] = tmpboard[1][0].dup
        tmpboard[2][1] = tmpboard[1][1].dup
        tmpboard[2][2] = tmpboard[1][2].dup
        tmpboard[2][emptysquares[2][k][0]][emptysquares[2][k][1]] = val

        checkwinner = checkwin(tmpboard[2])
        if (checkwinner==val)
          best_moves.push(emptysquares[0][i])
        end
  
        if (checkfork(tmpboard[2],val))
          best_moves.push(emptysquares[0][i])
        end
        
        if (checkpotentialwin(tmpboard[2],val))
          ok_moves.push(emptysquares[0][i])
        end
      end
    end
  end

  for z in 0..bad_moves.length-1
    best_moves.delete(bad_moves[z])
  end

  if best_moves.length > 0
    return largestoccuring(best_moves)
  elsif ok_moves.length > 0
    return largestoccuring(ok_moves)
  else
    emptysquares = checkemptysquares(board)
    return emptysquares[(rand()*(emptysquares.length)).floor()]
  end
end

################################################################################################
# A method that predicts the next move NO DEBUG MODE
################################################################################################
def computerpredictmove(board, val)
  # Check for an empty square
  tmpboard = Array.new
  emptysquares = checkemptysquares(board)
  for i in 0..emptysquares.length-1
    tmpboard[0] = board[0].dup
    tmpboard[1] = board[1].dup
    tmpboard[2] = board[2].dup
    tmpboard[emptysquares[i][0]][emptysquares[i][1]] = val
    if (checkwin(tmpboard)!=false)
      return emptysquares[i]
    end
  end
  return -1
end

################################################################################################
# A method to check which squares are empty on the board
################################################################################################
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

################################################################################################
# A method that swaps turns and returns the opponent's piece
################################################################################################
def swapturn(val)
  return (val-1).abs
end

################################################################################################
# A method that returns the largest occuring value within an array
################################################################################################
def largestoccuring(best_moves)
  n = best_moves.uniq
  f = Array.new
  for z in 0..n.length-1
    f.push(best_moves.count(n[z]))
  end
  return n[f.index(f.max)]
end

################################################################################################
# A method that checks if the move is a "fork" - a powerful move
################################################################################################
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

################################################################################################
# A method that counts the number of instances of 'val' on the board
################################################################################################
def countinst(board, val)
  c = 0
  for i in 0..board.length-1
  c += board[i].count(val)
  end
  return c
end

################################################################################################
# A method that finds the index of 'val' on the board in x,y coordinates
################################################################################################
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

################################################################################################
# A method that replaces n-th index of an occurence of 'val' on a board with 'replaceval'
################################################################################################
def replacenthindexof(board, val, replaceval, n)
    tmpboard = Array.new
    for i in 0..board.length-1
      tmpboard[i] = board[i].dup
    end

    c = findindexof(tmpboard, val)
    tmpboard[c[n][0]][c[n][1]] = replaceval

    return tmpboard
end

################################################################################################
# A method that checks if the move is a "potential" win
################################################################################################
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

# THESE METHODS ARE NO LONGER NEEDED

# def checkblock(board, val)
#   # val is the value that I'm blocking
#   # All win states:
#   # Row A, Row B, Row C
#   # Column 1, Column 2, Column 3
#   # A1, B2, C3
#   # C1, B2, A3

#   #board.map do ||
#   #end
#   tmparray = Array.new
#   tmparray[0] = Array.new
#   tmparray[1] = Array.new

#   for i in 0..2
#     # Check each column
#     tmpboard = board.transpose
#     if (tmpboard[i].uniq.length == 2 and tmpboard[i].compact.length == 3 and tmpboard[i].count(val) < tmpboard[i].count(swapturn(val)))
#       return true
#     end

#     # Check each row
#     if (board[i].uniq.length == 2 and board[i].compact.length == 3 and tmpboard[i].count(val) < tmpboard[i].count(swapturn(val)))
#         return true
#     end

#     # Diagonal A1, B2, C3
#     tmparray[0].push(board[i][i])

#     # Diagonal C1, B2, A3
#     tmparray[1].push(board[2-i][i])
#   end
  
#   if (tmparray[0].uniq.length == 2 and tmparray[0].compact.length == 3 and tmpboard[i].count(val) > tmpboard[i].count(swapturn(val)))  # Diagonal A1, B2, C3
#     return true
#   elsif (tmparray[1].uniq.length == 2 and tmparray[1].compact.length == 3 and tmpboard[i].count(val) > tmpboard[i].count(swapturn(val)))  # Diagonal C1, B2, A3
#     return true
#   end

#   return false
# end


  
  # ################################################################################################
  # # A method that predicts the next move NO DEBUG MODE
  # ################################################################################################
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

#   # ################################################################################################
# # # A method that predicts the next move DEBUG MODE ACTIVE
# # ################################################################################################
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
#     # elsif checkfork(tmpboard)!=false
#     #   print "\n\t\tPossible fork found\n"
#     #   return emptysquares[i]
#     end
#   end
#   return -1
# end



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


  # ################################################################################################
# # # A method that predicts the next move NO DEBUG MODE
# # ################################################################################################
# def areequal(val)
#   if (val.compact.length != 0)
#     return (val.uniq.length == 1)
#   end
# end


# ################################################################################################
# # A method that predicts the board - DEBUG MODE
# ################################################################################################
# def computerpredictbestmove(board, val, n=1)
#   tmpboard = Array.new
#   tmpboard[0] = Array.new
#   tmpboard[1] = Array.new
#   tmpboard[2] = Array.new
#   emptysquares = Array.new
#   best_moves = Array.new
#   ok_moves = Array.new
#   bad_moves = Array.new

#   commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2} #debug

#   emptysquares[0] = checkemptysquares(board)
#   for i in 0..emptysquares[0].length-1
#     tmpboard[0][0] = board[0].dup
#     tmpboard[0][1] = board[1].dup
#     tmpboard[0][2] = board[2].dup
#     emptysquares[0] = checkemptysquares(tmpboard[0])
#     tmpboard[0][emptysquares[0][i][0]][emptysquares[0][i][1]] = val
#     print "\n\t(#{val}): "             #debug
    
#     print "\""
#     print arraytocommandsparser(emptysquares[0][i], commands).join
#     print "\""

#     if (checkfork(tmpboard[0],val))
#       puts "\n\tWith this I can fork the opponent"
#       best_moves.push(emptysquares[0][i])
#     end

#     if (checkpotentialwin(tmpboard[0],val))
#       puts "\n\tThis is a good move for me (the computer)"
#       ok_moves.push(emptysquares[0][i])
#     end


#     emptysquares[1] = checkemptysquares(tmpboard[0])
#     for j in 0..emptysquares[1].length-1
#       tmpboard[1][0] = tmpboard[0][0].dup
#       tmpboard[1][1] = tmpboard[0][1].dup
#       tmpboard[1][2] = tmpboard[0][2].dup
#       tmpboard[1][emptysquares[1][j][0]][emptysquares[1][j][1]] = swapturn(val)
#       print "\n\t\t(#{swapturn(val)}): "             #debug


#       print "\""
#       print arraytocommandsparser(emptysquares[1][j], commands).join
#       print "\""

#       showsimpleboard(tmpboard[1])

#       predictloss = checkwin(tmpboard[1])
#       # print "DETERGENT: "
#       # puts predictloss
#         if (predictloss==swapturn(val))
#           puts "\n\t\t\tThis move will make me lose"
#           bad_moves.push(emptysquares[0][i])
#           # break
#         end

#       if (checkfork(tmpboard[1],swapturn(val)))
#         # best_moves.delete(emptysquares[i])
#         bad_moves.push(emptysquares[0][i])
#         puts "\n\t\tDanger! Potential opponent fork detected!"
#         # break
#       end
      
#       if (checkpotentialwin(tmpboard[1],swapturn(val)))
#         puts "\n\t\tThis is a good move for the opponent (Player 1)"
#       end
      


#       emptysquares[2] = checkemptysquares(tmpboard[1])
#       for k in 0..emptysquares[2].length-1
#         tmpboard[2][0] = tmpboard[1][0].dup
#         tmpboard[2][1] = tmpboard[1][1].dup
#         tmpboard[2][2] = tmpboard[1][2].dup
#         tmpboard[2][emptysquares[2][k][0]][emptysquares[2][k][1]] = val
#         print "\n\t\t\t--(#{val}): "             #debug

#         print "\""
#         print arraytocommandsparser(emptysquares[2][k], commands).join
#         print "\""

#         # print emptysquares2[k]
#         # showsimpleboard(tmpboard[2])
        
#         checkwinner = checkwin(tmpboard[2])
#         print "DETERGENT: "
#         puts checkwinner
#         if (checkwinner==val)
#           puts "\n\t\t\t-- This move will make me (the computer) win" ## But if I try anything else I will lose, right?
#           best_moves.push(emptysquares[0][i])
#         end
  
#         if (checkfork(tmpboard[2],val))
#           puts "\n\t\t\t-- With this I can fork the opponent"
#           best_moves.push(emptysquares[0][i])
#         end
        
#         if (checkpotentialwin(tmpboard[2],val))
#           puts "\n\t\t\t-- This is a good move for me (the computer)"
#           ok_moves.push(emptysquares[0][i])
#         end
#       end
#     end
#   end



#   puts ""
#   print "\t\tBest moves for the computer (2):\n\t\t\t"
#   for z in 0..(best_moves.uniq.length-1)
#     print "\""
#     print arraytocommandsparser(best_moves[z], commands).join
#     print "\""
#     print ", "
#   end

#   puts ""
#   print "\t\tOK moves for the computer (2):\n\t\t\t"
#   for z in 0..(ok_moves.uniq.length-1)
#     print "\""
#     print arraytocommandsparser(ok_moves[z], commands).join
#     print "\""
#     print ", "
#   end

#   puts ""
#   print "\t\tBad moves for the computer (2):\n\t\t\t"
#   for z in 0..(bad_moves.uniq.length-1)
#     print "\""
#     print arraytocommandsparser(bad_moves[z], commands).join
#     print "\""
#     print ", "
#   end  

#   for z in 0..bad_moves.length-1
#     best_moves.delete(bad_moves[z])
#   end

#   if best_moves.length > 0
#     return [largestoccuring(best_moves)]
#   elsif ok_moves.length > 0
#     return [largestoccuring(ok_moves)]
#   else
#     emptysquares = checkemptysquares(board)
#     puts "Generating random square......"
#     return [emptysquares[(rand()*(emptysquares.length)).floor()]]
#   end
# end