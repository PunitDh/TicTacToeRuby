###############################################################################################
# A method that lets the computer play
################################################################################################
def computermove(game, currentplayer)
  computer_response = computerresponse(game.board, currentplayer.val)
  print game.moverecord.length == 0 ? "\n\n\t\tComputer's (#{currentplayer.str}) first move: " : "\n\t\tComputer (#{currentplayer.str}) responds: "
  game.moverecord.push(computer_response)
  command_response = arraytocommandsparser(computer_response, game.commands)
  print "\"#{command_response.join()}\"\n"
  game.playmove(computer_response,currentplayer.val)
  print (!$foo==0) ? "\n\t\tPerformed #{$foo} iterations...\n" : nil
  return swapturn(currentplayer, game.players)
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
    $foo = 0
    predictwin = computerpredictwin(board, emptysquares, val)
    return predictwin if predictwin
    predictloss = computerpredictwin(board, emptysquares, otherval(val))
    return predictloss if predictloss
    best_move = minimax(board,val)
    return [best_move[:r], best_move[:c]]
  end
end

################################################################################################
# A method that predicts the next move NO DEBUG MODE
################################################################################################
def computerpredictwin(board, emptysquares, val)
  # Check for an empty square
  tmpboard = Array.new
  emptysquares.map do |empty|
    tmpboard = board.map { |row| row.map { |cell| cell } }
    tmpboard[empty[0]][empty[1]] = val
    return empty if checkwin(tmpboard)
  end
  return false
end

################################################################################################
# The minimax recursion function
################################################################################################
def minimax(board, val, maximising_player = true)
  tmpboard = Array.new
  best_move = {"r":nil, "c":nil, "score":0}
  
  if (checkwin(board))
      best_move[:score] = maximising_player ? -1 : 1
    return best_move
  elsif (checkdraw(board))
    best_move[:score] = 0
    return best_move
  end

  best_move[:score] = maximising_player ? -2 : 2

  board.map.with_index do |row,i|
    row.map.with_index do |cell,j|
      if cell.nil?
        tmpboard = board.map { |row| row.map { |cell| cell } }
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
        tmpboard = board.map { |row| row.map { |cell| cell } }
      end
    end
  end
  return best_move
end


################################################################################################
# A method to check which squares are empty on the board
################################################################################################
def findemptysquares(board)
  return board.map.with_index { |row,i| row.map.with_index { |cell,j| [i,j] if cell.nil? }}.flatten(1).compact
end

################################################################################################
# A method that returns the opponent's piece
################################################################################################
def otherval(val)
	return (val-1).abs
end

################################################################################################
# A method that swaps turns
################################################################################################
def swapturn(currentplayer, player)
    return (currentplayer == player[0]) ? player[1] : player[0]
end