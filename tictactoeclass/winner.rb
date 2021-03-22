def winner?(rows)
    for row in rows
        return row.first if winning_row?(row)
    end
    
    for row in rows.transpose
        return row.first if
        winning_row?(row)
    end

    false
end

def winning_row?(row)
    compacted_length = row.compact.length
    unique_length = row.uniq.length
    (compacted_length == 3) && (unique_length == 1)
end