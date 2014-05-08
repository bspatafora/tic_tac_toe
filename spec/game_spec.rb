require 'spec_helper'

describe TicTacToe::Game do
  let(:game) { TicTacToe::Game.new }

  describe '#place' do
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

  describe '#diagonal_victory?' do
    it "returns false if a token has not achieved diagonal victory" do
      expect(game.diagonal_victory?(:X)).to be false
    end

    it "returns true if a token has achieved back diagonal victory" do
      string = "07468"
      generate_board_from(string, game)
      expect(game.diagonal_victory?(:X)).to be true
    end

    it "returns true if a token has achieved front diagonal victory" do
      string = "20416"
      generate_board_from(string, game)
      expect(game.diagonal_victory?(:X)).to be true
    end
  end

  describe '#horizonal_victory?' do
    it "returns false if a token has not achieved horizonatal victory" do
      expect(game.horizontal_victory?(:X)).to be false
    end

    it "returns true if a token has achieved horizonatal victory" do
      string = "08172"
      generate_board_from(string, game)
      expect(game.horizontal_victory?(:X)).to be true
    end
  end

  describe '#vertical_victory?' do
    it "returns false if a token has not achieved vertical victory" do
      expect(game.vertical_victory?(:X)).to be false
    end

    it "returns true if a token has achieved horizonatal victory" do
      string = "08376"
      generate_board_from(string, game)
      expect(game.vertical_victory?(:X)).to be true
    end
  end

  def generate_board_from(string, game)
    string.each_char do |char|
      move = char.to_i
      game.place(move)
    end
  end
end
