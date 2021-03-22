def winner?(rows)
    for row in rows
        return row.first if winning_row?(row)
    end
    
    for row in rows.transpose
        return row.first if winning_row?(row)
    end

    # tmp = Array.new
    # tmp[0] = []
    # tmp[1] = []
    # for row in 0..2
    #     tmp[0] = rows[row]
    #     tmp[1] = rows[2-row]
    # end

    # for row in tmp
    #     return row.first if winning_row?(row)
    # end

    false
end

def draw?(rows)
    rows.flatten.compact.length == 9
end

def winning_row?(row)
    compacted_length = row.compact.length
    unique_length = row.uniq.length
    (compacted_length == 3) && (unique_length == 1)
end