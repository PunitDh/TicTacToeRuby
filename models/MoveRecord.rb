#############################################################################
# The MoveRecord class creates a record of moves to save to a JSON file
#############################################################################  
class MoveRecord
	attr_reader :filename, :record

	def initialize(filename = "./gameresults.json")
		uuid = UUID.new
		@record = {"UUID": uuid.generate, "DateTime": nil, "Players": [], "Moves": [], "Winner": nil}
		@filename = filename
	end

	def setplayers(players)
		@record[:Players] = players
	end

	def setwinner(player)
		@record[:Winner] = player
	end

	def push(move)
		@record[:Moves].push(move)
	end

	def length
		@record[:Moves].length
	end

	def to_s
		@record.to_s
	end
end