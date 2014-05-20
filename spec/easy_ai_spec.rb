require 'spec_helper'
require 'tic_tac_toe/easy_ai'

describe TicTacToe::EasyAI do
  describe '#make_move' do
    let(:players) { double("players") }
    let(:ai) { TicTacToe::EasyAI }

    it "makes a random, valid move" do
      structure = [:O, nil, nil,
                   nil, :X, nil,
                   nil, :X, nil]
      board = generate_board(structure)
      valid_moves = [1, 2, 3, 5, 6, 8]

      move = ai.make_move(board, players)
      expect(valid_moves).to include(move)
    end
  end
end
