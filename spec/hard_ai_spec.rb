require 'spec_helper'
require 'tic_tac_toe/hard_ai'

describe TicTacToe::HardAI do
  let(:human_player) { double("human player", token: :X) }
  let(:computer_player) { double("computer player", token: :O) }
  let(:players) { [computer_player, human_player] }
  let(:ai) { TicTacToe::HardAI }


  describe '#make_move' do
    it "returns the best move" do
      structure = [:X, nil, nil,
                   :O,  :O, nil,
                   :X, nil,  :X]
      board = generate_board(structure)
      best_move = 5

      expect(ai.make_move(board, players)).to eql(best_move)
    end
  end


  describe '#minimax' do
    it "returns the correct score for a pre-win board" do
      structure = [:X, nil, nil,
                   :O,  :O, nil,
                   :X, nil,  :X]
      board = generate_board(structure)
      win_score = 1

      expect(ai.minimax(board, :max, players)).to eql(win_score)
    end

    it "returns the correct score for a pre-loss board" do
      structure = [ :O,  :O,  :X,
                   nil, nil, nil,
                    :X, nil,  :X]
      board = generate_board(structure)
      loss_score = -1

      expect(ai.minimax(board, :max, players)).to eql(loss_score)
    end

    it "returns the correct score for a pre-draw board" do
      structure = [:X,  :X, :O,
                   :O, nil, :X,
                   :X,  :O, :X]
      board = generate_board(structure)
      draw_score = 0

      expect(ai.minimax(board, :max, players)).to eql(draw_score)
    end
  end


  describe '#generate_board' do
    it "returns a board based on a token, a space, and an existing board" do
      token, space = :O, 3
      structure = [ :X, nil, nil,
                   nil,  :O, nil,
                    :X, nil, nil]
      board = generate_board(structure)

      new_board = ai.generate_board(token, space, board)
      expect(new_board.space(space)).to eql(token)
    end
  end


  describe '#score' do
    let(:opponent) { double("opponent", token: :X) }
    let(:hard_ai) { double("hard ai", token: :O) }
    let(:players) { [hard_ai, opponent] }

    it "returns the correct score when HardAI has won" do
      structure = [ :O, nil, nil,
                   nil,  :O, nil,
                   nil, nil,  :O]
      board = generate_board(structure)
      win_score = 1

      expect(ai.score(board, players)).to eql(win_score)
    end

    it "returns the correct score when no one has won" do
      structure = [:O, :O, :X,
                   :X, :X, :O,
                   :O, :X, :O]
      board = generate_board(structure)
      draw_score = 0

      expect(ai.score(board, players)).to eql(draw_score)
    end

    it "returns the correct score when the opponent has won" do
      structure = [ :X, nil, nil,
                   nil,  :X, nil,
                   nil, nil,  :X]
      board = generate_board(structure)
      loss_score = -1

      expect(ai.score(board, players)).to eql(loss_score)
    end
  end
end
