require 'spec_helper'
require 'tic_tac_toe/easy_ai'

describe TicTacToe::EasyAI do
  describe '#make_move' do
    it "makes a random, valid move" do
      structure = [:O, nil, nil,
                   nil, :X, nil,
                   nil, :X, nil]
      board = generate_board(structure)
      players = double("players")
      valid_moves = [1, 2, 3, 5, 6, 8]
      ai = TicTacToe::EasyAI
      move = ai.make_move(board, players)
      expect(valid_moves).to include(move)
    end
  end
end
