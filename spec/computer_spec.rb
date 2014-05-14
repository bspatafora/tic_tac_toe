require 'spec_helper'

describe TicTacToe::Computer do
  let(:board) { TicTacToe::Board.new }
  let(:game) { TicTacToe::Game.new(board) }
  let(:computer) { TicTacToe::Computer.new(game) }

  describe '#make_move' do
    it "returns the best move" do
      structure = [:X, nil, nil,
                   :O, :O, nil,
                   :X, nil, :X]
      board = generate_board(structure)
      expect(computer.make_move(board)).to eql(5)
    end
  end

  describe '#minimax' do
    it "correctly scores pre-win" do
      structure = [:X, nil, nil,
                   :O, :O, nil,
                   :X, nil, :X]
      board = generate_board(structure)
      expect(computer.minimax(board, computer.computer_token)).to eql(1)
    end

    it "correctly scores pre-loss" do
      structure = [:O, :O, :X,
                   nil, nil, nil,
                   :X, nil, :X]
      board = generate_board(structure)
      expect(computer.minimax(board, computer.computer_token)).to eql(-1)
    end

    it "correctly scores pre-draw" do
      structure = [:O, :O, :X,
                   :X, nil, :O,
                   :O, :X, :O]
      board = generate_board(structure)
      expect(computer.minimax(board, computer.human_token)).to eql(0)
    end
  end

  describe '#generate_board' do
    it "generates a new board based on a move and a board" do
      structure = [:X, nil, nil,
                   nil, :O, nil,
                   :X, nil, nil]
      board = generate_board(structure)
      new_board = computer.generate_board(3, computer.computer_token, board)
      expect(new_board.read(3)).to eql(:O)
    end
  end

  describe '#generate_moves' do
    it "generates possible next moves based on a board" do
      structure = [:X, :O, nil,
                   :O, :O, :X,
                   :X, :X, nil]
      board = generate_board(structure)
      expect(computer.generate_moves(board)).to eql([2, 8])
    end
  end

  describe '#score' do
    it "returns 1 if the computer has won" do
      structure = [:O, nil, nil,
                   nil, :O, nil,
                   nil, nil, :O]
      board = generate_board(structure)
      expect(computer.score(board)).to eql(1)
    end

    it "returns 0 if no one has won" do
      structure = [:O, :O, :X,
                   :X, :X, :O,
                   :O, :X, :O]
      board = generate_board(structure)
      expect(computer.score(board)).to eql(0)
    end

    it "returns -1 if another player has won" do
      structure = [:X, nil, nil,
                   nil, :X, nil,
                   nil, nil, :X]
      board = generate_board(structure)
      expect(computer.score(board)).to eql(-1)
    end
  end
end
