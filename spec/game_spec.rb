require 'spec_helper'

describe TicTacToe::Game do
  describe '#place' do
    let(:game) { TicTacToe::Game.new }

    it "places a valid move" do
      game.place(0)
      expect(game.board[0]).to eql(:X)
    end

    it "rotates the tokens after a valid move" do
      game.place(0)
      game.place(1)
      expect(game.board[1]).to eql(:O)
    end

    it "doesn't place a move if the space is occupied" do
      game.place(0)
      expect{ game.place(0) }.to raise_error(TicTacToe::InvalidMove)
    end

    it "doesn't place a move if it's off the board" do
      expect{ game.place(9) }.to raise_error(TicTacToe::InvalidMove)
    end
  end
end
