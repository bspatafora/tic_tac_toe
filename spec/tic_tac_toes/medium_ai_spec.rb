require 'tic_tac_toes/medium_ai'
require 'tic_tac_toes/spec_helper'

describe TicTacToes::MediumAI do
  let(:medium_ai) { TicTacToes::MediumAI }
  let(:x) { TicTacToes::Player.new("move_strategy", "x", false, "interface") }
  let(:o) { TicTacToes::Player.new(medium_ai, "o", true, "interface") }
  let(:players) { [x, o] }

  describe '#move' do
    it "returns a valid move (based on either EasyAI or HardAI)" do
      structure = [  o, o,   x,
                   nil, x, nil,
                   nil, x, nil]
      board = generate_board(structure)
      valid_moves = [3, 5, 6, 8]

      move = medium_ai.move(board, players)
      expect(valid_moves).to include(move)
    end
  end
end
