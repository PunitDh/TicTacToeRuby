require_relative "../models/game-classes.rb"

describe Game do
	it 'should create an empty board on initialization' do
		game = Game.new
		expect(game.board).to eq([[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]])
	end

	it 'should find an empty square when given the board' do
		board = [[1,nil,0], [nil,1,nil], [nil,0,nil]]
		emptysquares = findemptysquares(board)
		expect(emptysquares).to eq([[0,1], [1,0], [1,2], [2,0], [2,2]])
	end

	it 'should allow us to input a move in an empty square' do
		game = Game.new
		game.entermove([0,1],1)
		expect(game.board).to eq([[nil,1,nil], [nil,nil,nil], [nil,nil,nil]])
	end

	it 'should return true if the board is in a win state' do
		game = Game.new
		game.entermove([0,0], 1)
		game.entermove([0,1], 0)
		game.entermove([1,1], 1)
		game.entermove([1,2], 0)
		game.entermove([2,2], 1)
		expect(checkwin(game.board)).to eq(1)
	end

	it 'should return true is the board is in a draw state' do
		game = Game.new
		game.entermove([1, 1], 1)
		game.entermove([0, 0], 0)
		game.entermove([0, 1], 1)
		game.entermove([2, 1], 0)
		game.entermove([1, 0], 1)
		game.entermove([1, 2], 0)
		game.entermove([0, 2], 1)
		game.entermove([2, 0], 0)
		game.entermove([2, 2], 1)
		expect(checkdraw(game.board)).to be(true)
		expect(checkwin(game.board)).to eq(false)
	end

	it 'should check a command to see whether it is valid' do
		game = Game.new
		expect(validatecommand(game,"A2")).to eq([0,1])
		expect(validatecommand(game,"2A")).to eq([0,1])
		expect(validatecommand(game,"231ABC")).to eq(false)
		game.entermove([1,1],1)
		expect(validatecommand(game,"B2")).to eq(false)
	end

	it 'should allow computer to make a move to win' do
		game = Game.new
		game.entermove([0,0], 1)
		game.entermove([0,1], 0)
		game.entermove([1,1], 1)
		game.entermove([1,2], 0)
		emptysquares = findemptysquares(game.board)
		move = computerpredictwin(game.board,emptysquares,1)
		expect(move).to eq([2,2])
		game.entermove(move, 1)
		expect(checkwin(game.board)).to be(1)
	end

	it 'should allow computer to block opponent win' do
		game = Game.new
		game.entermove([0,0], 0)
		game.entermove([0,1], 1)
		game.entermove([1,1], 0)
		game.entermove([1,2], 1)
		emptysquares = findemptysquares(game.board)
		move = computerpredictwin(game.board,emptysquares,0)
		expect(move).to eq([2,2])
		game.entermove(move, 0)
		expect(checkwin(game.board)).to eq(0)
	end

	it 'find the best possible move in a circumstance' do
		game = Game.new
		game.entermove([0,0], 0)
		move = computerresponse(game.board,1)
		expect(move).to eq([1,1])
		game.entermove(move, 1)
	end

	it 'should return the value at any given square, i.e. X, O or nil' do
		game = Game.new
		game.entermove([0,0], 0)
		game.entermove([0,1], 1)
		game.entermove([1,1], 0)
		game.entermove([1,2], 1)
		expect(game.get(0,1)).to be(1)
		expect(game.get(1,1)).to be(0)
		expect(game.get(0,2)).to be(nil)
	end

	it 'should swap the turn and return the opponent piece, i.e. either 1 or 0' do
		expect(otherval(1)).to be(0)
		expect(otherval(0)).to be(1)
	end

	it 'should find the player that holds either X or O, i.e. 1 or 0' do
		game = Game.new
		Player.new()
		expect(otherval(1)).to be(0)
		expect(otherval(0)).to be(1)
	end	
end