require 'tic_tac_toe/hard_ai'
require 'tic_tac_toe/player'
require 'tic_tac_toe/spec_helper'

describe TicTacToe::HardAI do
  let(:ai) { TicTacToe::HardAI }
  let(:x) { TicTacToe::Player.new("decider", "x", false, "interface") }
  let(:o) { TicTacToe::Player.new(ai, "o", true, "interface") }
  let(:players) { [o, x] }


  describe '#make_move' do
    it "returns the best move" do
      structure = [x, nil, nil,
                   o,   o, nil,
                   x, nil,   x]
      board = generate_board(structure)
      best_move = 5

      expect(ai.make_move(board, players)).to eql(best_move)
    end
  end


  describe '#minimax' do
    it "returns the correct score for a pre-win board" do
      structure = [x, nil, nil,
                   o,   o, nil,
                   x, nil,   x]
      board = generate_board(structure)
      win_score = 1

      expect(ai.minimax(board, :max, players)).to eql(win_score)
    end

    it "returns the correct score for a pre-loss board" do
      structure = [  o,   o,   x,
                   nil, nil, nil,
                     x, nil,   x]
      board = generate_board(structure)
      loss_score = -1

      expect(ai.minimax(board, :max, players)).to eql(loss_score)
    end

    it "returns the correct score for a pre-draw board" do
      structure = [x,   x, o,
                   o, nil, x,
                   x,   o, x]
      board = generate_board(structure)
      draw_score = 0

      expect(ai.minimax(board, :max, players)).to eql(draw_score)
    end
  end


  describe '#generate_board' do
    it "returns a board based on a token, a space, and an existing board" do
      token, space = o, 3
      structure = [  x, nil, nil,
                   nil,   o, nil,
                     x, nil, nil]
      board = generate_board(structure)

      new_board = ai.generate_board(token, space, board)
      expect(new_board.space(space)).to eql(token)
    end
  end


  describe '#score' do
    it "returns the correct score when HardAI has won" do
      structure = [  o, nil, nil,
                   nil,   o, nil,
                   nil, nil,   o]
      board = generate_board(structure)
      win_score = 1

      expect(ai.score(board, players)).to eql(win_score)
    end

    it "returns the correct score when no one has won" do
      structure = [o, o, x,
                   x, x, o,
                   o, x, o]
      board = generate_board(structure)
      draw_score = 0

      expect(ai.score(board, players)).to eql(draw_score)
    end

    it "returns the correct score when the opponent has won" do
      structure = [  x, nil, nil,
                   nil,   x, nil,
                   nil, nil,   x]
      board = generate_board(structure)
      loss_score = -1

      expect(ai.score(board, players)).to eql(loss_score)
    end
  end
end
