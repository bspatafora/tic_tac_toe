require 'spec_helper'

describe TicTacToe::Game do
  describe '#place' do
    it "doesn't place an invalid move on the board" do
      game = TicTacToe::Game.new
      expect{ game.place(9) }.to raise_error(TicTacToe::InvalidMove)
    end
  end
end
