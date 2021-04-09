module Views
	module Prompts
		######### A method used to get a 'nil' user input #######################################################################
		def self.tmpgets
			tmp = $stdin.gets
		end

		####### # A method used to print a message inside a box #################################################################
		def self.prompt(question, choices, halign: 95)
			prompt = TTY::Prompt.new(symbols: {marker: " "})
			prompt.select("#{question}\n".center(halign), choices, show_help: :never, cycle: true)
		end
	end
end