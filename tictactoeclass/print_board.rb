#-----------------------------------------------
#--- Print board method ------------------------
def print_board(rows)
    # Print the board
    board = rows.map do |row|
        display_row = row.map do |cell|
            cell.nil? ? " " : cell
        end

        display_row.join("|")
    end
    puts board.join("\n" + ("-"*5) + "\n")
end