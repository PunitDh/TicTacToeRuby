require "./print_board.rb"
require "./player_move.rb"
require "./winner.rb"

rows = [
 [nil,nil,nil],
 [nil,nil,nil],
 [nil,nil,nil]
]

winner = nil

#--START THE GAME
print_board(rows)

['x','o'].cycle do |player|
    player_move(rows, player)
    print_board(rows)
    break if (winner = winner?(rows)) or draw?(rows)
end

# Finish
if winner
    puts "#{winner} is the winner!"
else
    puts "a draw :("
end
# print_board(rows)
