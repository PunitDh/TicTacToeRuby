#############################################################################
# A method that converts string commands to array indexes that
# refer to positions on the board
#############################################################################
def commandparser(commands, board, command)
    commands = Array.new
    case command[0]
      when "A"
        commands[0] = 0
      when "B"
        commands[0] = 1
      when "C"
        commands[0] = 2
      when "H"
        showhelp(board)
        commands[1] = -2
        return commands      
      else
        return false
    end
  
    case command[1]
      when "1"
        commands[1] = 0
      when "2"
        commands[1] = 1
      when "3"
        commands[1] = 2
      else
        return false
    end
  
    return commands
end
  
#############################################################################
# A method that converts board array values commands to grid display indices
#############################################################################
def arraytodisplayparser(command)
    commands = Array.new
    commands[0] = (command[0] < 3) ? (command[0] + 1)*2   : -1
    commands[1] = (command[1] < 3) ? ((command[1]+1)*4)+1 : -1
    return commands
end
  
#############################################################################
# A method that converts board array values commands to grid display indices
#############################################################################
def arraytocommandsparser(command, commands)
    output = Array.new
    output[0] = commands.key(command[0])
    output[1] = (command[1]+1).to_s
    return output
end
  
  
#############################################################################
# A method that converts commands to display indices
#############################################################################
def displayparser(commands, command)
    output = Array.new
    cmd = commands[command[0]]
    output[0] = (cmd.nil? or cmd == -2) ? -1 : (cmd+1)*2
    cmd = command[1].to_i
    output[1] = (cmd < 1 or cmd > 3 or cmd.nil?) ? -1 : (cmd.to_i*4)+1
    return output
end
