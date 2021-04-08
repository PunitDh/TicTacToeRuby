#!/usr/bin/env ruby

require 'json'
require 'tty-table'
require './models/Parser.rb'
require './models/Game.rb'
require 'time'

def gamestats(filename = "gameresults.json")
	commands = {"A"=>0, "B"=>1, "C"=>2, "H"=>-2}
	nlines = 0
	lines = []
	winners = []
	moves = []
	players = []
	times = []
	file = File.open(filename)
	File.foreach(filename) do |line|
		begin
			eachline = JSON.parse(line)
		rescue StandardError => exception
			return puts "\t\t"+"-"*75+"\n\t\tUnable to load game save file.\n\n\t\tThe game save file \"#{@filename}\" is either corrupt or appears to have been tampered with.\n\n\t\tPlease delete the file \"#{@filename}\" and create a new one.\n\t\t"+"-"*75
		end
		lines << eachline
		winners << eachline["Winner"]
		moves << eachline["Moves"][0]
		players << eachline["Players"]
		times << eachline["DateTime"]
		nlines += 1
	end
	file.close
	puts "\n - Total number of games: #{nlines}"
	
	playernames = players.uniq.each { |player| player }
	print "\n - Total number of Draws: "
	puts winners.count("Draw")
	print "\n - Most popular opening move: "
	firstmoves = moves.map { |move| move }
	allmoves = firstmoves.uniq
	firstmoveqty = []
	allmoves.each { |move| firstmoveqty << [move, firstmoves.count(move)] }
	quantities = firstmoveqty.transpose[1]
	p Parser::arraytocmd(firstmoveqty[quantities.index(quantities.max)][0], commands).join
	puts ""
	(players.uniq).each do |player|
		print " - #{player[0][0..player[0].length-4]} started first: " + (players.count(player)).to_s + " times\n\n" 
	end
	print " - #{playernames.flatten[0][0..playernames.flatten[0].length-4]} won: " + (winners.count(playernames.flatten[0]) + winners.count(playernames.flatten[3])).to_s + " times\n\n"
	print " - #{playernames.flatten[1][0..playernames.flatten[1].length-4]} won: " + (winners.count(playernames.flatten[1]) + winners.count(playernames.flatten[2])).to_s + " times\n\n"
	print " - Total time taken for simulation: " 
	timetaken = Time.parse(times[times.length-1]) - Time.parse(times[0])
	print (timetaken / 60).floor.to_s + " mins " + (timetaken % 60).to_s + " seconds\n\n"
end