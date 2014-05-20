require 'spec_helper'
require 'tic_tac_toe/medium_ai'

describe TicTacToe::MediumAI do
  let(:human_player) { double("human player", :token => :X) }
  let(:computer_player) { double("computer player", :token => :O) }
  let(:players) { [human_player, computer_player] }

  describe '#make_move' do
    it "makes a valid move" do
      structure = [:O, :O, :X,
                   nil, :X, nil,
                   nil, :X, nil]
      board = generate_board(structure)
      valid_moves = [3, 5, 6, 8]
      ai = TicTacToe::MediumAI
      move = ai.make_move(board, players)
      expect(valid_moves).to include(move)
    end
  end
end

