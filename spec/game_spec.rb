require 'spec_helper'

describe TicTacToe::Game do
  describe '#place' do
    let(:game) { TicTacToe::Game.new }

    it "places a valid move on the board" do
      game.place(0)
      expect(game.board[0]).to eql(:X)
    end

    it "doesn't place an invalid move on the board" do
      expect{ game.place(9) }.to raise_error(TicTacToe::InvalidMove)
    end
  end
end
