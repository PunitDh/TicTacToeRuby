#!/usr/bin/env ruby

begin
	print "Enter a command (new, quit): "
	request, param = gets.chomp.downcase.strip.split(' ')
  
	if ['new','n'].include? request
	  GameController::create
	end
  
  end until ['quit', 'q', 'exit'].include? request