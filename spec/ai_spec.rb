require 'spec_helper'

describe TicTacToe::AI do
  let(:human_player) { double("human player", :token => :X) }
  let(:computer_player) { double("computer player", :token => :O) }
  let(:players) { [computer_player, human_player] }
  let(:ai) { TicTacToe::AI }


  describe '#make_move' do
    it "returns the best move" do
      structure = [:X, nil, nil,
                   :O, :O, nil,
                   :X, nil, :X]
      board = generate_board(structure)
      winning_move = 5
      expect(ai.make_move(board, players)).to eql(winning_move)
    end
  end


  describe '#minimax' do
    it "correctly scores pre-win" do
      structure = [:X, nil, nil,
                   :O, :O, nil,
                   :X, nil, :X]
      board = generate_board(structure)
      win_score = 1
      expect(ai.minimax(board, :max, players)).to eql(win_score)
    end

    it "correctly scores pre-loss" do
      structure = [:O, :O, :X,
                   nil, nil, nil,
                   :X, nil, :X]
      board = generate_board(structure)
      loss_score = -1
      expect(ai.minimax(board, :max, players)).to eql(loss_score)
    end

    it "correctly scores pre-draw" do
      structure = [:X, :X, :O,
                   :O, nil, :X,
                   :X, :O, :X]
      board = generate_board(structure)
      draw_score = 0
      expect(ai.minimax(board, :max, players)).to eql(draw_score)
    end
  end


  describe '#generate_board' do
    it "generates a new board based on a move and a board" do
      structure = [:X, nil, nil,
                   nil, :O, nil,
                   :X, nil, nil]
      board = generate_board(structure)
      new_board = ai.generate_board(3, :O, board)
      expect(new_board.get_space(3)).to eql(:O)
    end
  end


  describe '#generate_moves' do
    it "generates possible next moves based on a board" do
      structure = [:X, :O, nil,
                   :O, :O, :X,
                   :X, :X, nil]
      board = generate_board(structure)
      open_spaces = [2, 8]
      expect(ai.generate_moves(board)).to eql(open_spaces)
    end
  end


  describe '#score' do
    it "correctly scores if the computer has won" do
      structure = [:O, nil, nil,
                   nil, :O, nil,
                   nil, nil, :O]
      board = generate_board(structure)
      win_score = 1
      expect(ai.score(board, players)).to eql(win_score)
    end

    it "correctly scores if no one has won" do
      structure = [:O, :O, :X,
                   :X, :X, :O,
                   :O, :X, :O]
      board = generate_board(structure)
      draw_score = 0
      expect(ai.score(board, players)).to eql(draw_score)
    end

    it "correctly scores if another player has won" do
      structure = [:X, nil, nil,
                   nil, :X, nil,
                   nil, nil, :X]
      board = generate_board(structure)
      loss_score = -1
      expect(ai.score(board, players)).to eql(loss_score)
    end
  end
end
