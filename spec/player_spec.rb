require 'spec_helper'
require 'tic_tac_toe/player'

describe TicTacToe::Player do
  describe '#make_move' do
    let(:board) { double("board", :place => true) }
    let(:players) { double("players") }
    let(:player) { TicTacToe::Player.new(double("test player"), :test_token) }

    it "asks its decider to make a move" do
      expect(player.decider).to receive(:make_move)
      player.make_move(board, players)
    end
  end
end
