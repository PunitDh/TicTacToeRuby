#-----------------------------------------------
#--- Print board method ------------------------
def player_move(rows, player)
    begin
        print "Player #{player} move: "
        coordinates = gets.chomp.split(',')
        coordinates = coordinates.map do |value|
            value = value.strip
            value.to_i - 1
        end
        x = coordinates[0]
        y = coordinates[1]
    end while rows[y][x]
    rows[y][x] = player
end