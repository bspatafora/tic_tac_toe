require 'tic_tac_toes/spec_helper'
require 'tic_tac_toes/easy_ai'

describe TicTacToes::EasyAI do
  describe '#move' do
    let(:players) { double("players") }
    let(:easy_ai) { TicTacToes::EasyAI }

    it "returns a randomly-selected valid move" do
      structure = [ :O, nil, nil,
                   nil,  :X, nil,
                   nil,  :X, nil]
      board = generate_board(structure)
      valid_moves = [1, 2, 3, 5, 6, 8]

      move = easy_ai.move(board, players)
      expect(valid_moves).to include(move)
    end
  end
end
