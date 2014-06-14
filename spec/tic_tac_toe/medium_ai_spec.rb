require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/spec_helper'

describe TicTacToe::MediumAI do
  let(:ai) { TicTacToe::MediumAI }
  let(:x) { TicTacToe::Player.new("decider", "x", false, "interface") }
  let(:o) { TicTacToe::Player.new(ai, "o", true, "interface") }
  let(:players) { [x, o] }

  describe '#make_move' do
    it "makes a valid move (based on either EasyAI or HardAI)" do
      structure = [  o, o,   x,
                   nil, x, nil,
                   nil, x, nil]
      board = generate_board(structure)
      valid_moves = [3, 5, 6, 8]

      move = ai.make_move(board, players)
      expect(valid_moves).to include(move)
    end
  end
end
