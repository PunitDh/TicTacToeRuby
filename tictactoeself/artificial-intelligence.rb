###############################################################################################
# A method that lets the computer play
################################################################################################
def computermove(game, currentplayer)
  computer_response = computerresponse(game[:board], currentplayer[:val])
  print game[:moverecord].length == 0 ? "\n\n\t\tComputer's  (#{currentplayer[:str]}) first move: " : "\n\t\tComputer (#{currentplayer[:str]}) responds: "
  game[:moverecord].push(computer_response)
  computer_response_command = arraytocommandsparser(computer_response, game[:commands])
  print "\"#{computer_response_command.join()}\"\n"
  computer_response_display = arraytodisplayparser(computer_response)
  game[:board][computer_response[0]][computer_response[1]] = currentplayer[:val]
  game[:board_display][computer_response_display[0]][computer_response_display[1]] = currentplayer[:str]
  showboard(game)
  print (!$foo.nil? or $foo==0) ? "\n\t\tPerformed #{$foo} iterations...\n" : nil
  return swapturn(currentplayer, game[:player])
end

###############################################################################################
# A method that spits out a computer response
################################################################################################
def computerresponse(board, val)
  emptysquares = findemptysquares(board)
  if (emptysquares.length == board.flatten.length)
    bestsquare = (rand()*(emptysquares.length)).floor()
    return emptysquares[bestsquare]
  else
    predictwin = computerpredictwin(board, val)
    return predictwin if (predictwin != -1)
    predictloss = computerpredictwin(board, otherval(val))
    return predictloss if (predictloss != -1)
    $foo = 0
    best_move = minimax(board,val)
    return [best_move[:r], best_move[:c]]
  end
end

################################################################################################
# A method that predicts the next move NO DEBUG MODE
################################################################################################
def computerpredictwin(board, val)
  # Check for an empty square
  tmpboard = Array.new
  emptysquares = findemptysquares(board)
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
# The minimax recursion function
################################################################################################
def minimax(board, val, maximising_player = true)
  tmpboard = Array.new
  best_move = {"r":nil, "c":nil, "score":0}
  
  if (checkwin(board))
    if maximising_player
      best_move[:score] = -1
    else
      best_move[:score] = 1
    end
    return best_move

  elsif (checkdraw(board))
    best_move[:score] = 0
    return best_move
  end

  best_move[:score] = maximising_player ? -2 : 2

  for i in 0..2
    for j in 0..2
      
      if board[i][j].nil?
        tmpboard[0] = board[0].dup
        tmpboard[1] = board[1].dup
        tmpboard[2] = board[2].dup
        tmpboard[i][j] = val
        
        board_state = minimax(tmpboard, otherval(val), !maximising_player)
        $foo += 1
        
        if (maximising_player)
          if (board_state[:score] > best_move[:score])
            best_move[:score] = board_state[:score]
            best_move[:r] = i
            best_move[:c] = j
          end
        else
          if (board_state[:score] < best_move[:score])
            best_move[:score] = board_state[:score]
            best_move[:r] = i
            best_move[:c] = j            
          end
        end
        tmpboard[0] = board[0].dup
        tmpboard[1] = board[1].dup
        tmpboard[2] = board[2].dup
      end
    end
  end
  return best_move
end


################################################################################################
# A method to check which squares are empty on the board
################################################################################################
def findemptysquares(board)
  emptysquares = []
  for i in 0..2
    for j in 0..2
      if (board[i][j].nil?)
        emptysquares.push([i,j])
      end
    end
  end
  return emptysquares
end

################################################################################################
# A method that returns the opponent's piece
################################################################################################
def otherval(val)
	return (val-1).abs
end

################################################################################################
# A method that swaps turns and returns the opponent's piece
################################################################################################
def swapturn(currentplayer, player)
    return (currentplayer == player[0]) ? player[1] : player[0]
end