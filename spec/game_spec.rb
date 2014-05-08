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

  describe '#over?' do
    it "returns false if the game is not over" do
      generate_board_from("04871263", game)
      expect(game.over?).to be false
    end

    it "returns true if there is a winner" do
      generate_board_from("706458", game)
      expect(game.over?).to be true
    end

    it "returns true if there is a draw" do
      generate_board_from("048712635", game)
      expect(game.over?).to be true
    end
  end

  describe '#determine_winner' do
    it "returns the winning token when there is a winner" do
      generate_board_from("706458", game)
      expect(game.determine_winner).to eql(:O)
    end

    it "returns false if there is not a winner" do
      expect(game.determine_winner).to be false
    end
  end

  describe '#win?' do
    it "returns false if a token has not won" do
      expect(game.win?(:X)).to be false
    end

    it "returns true if a token has achieved a back diagonal win" do
      generate_board_from("07468", game)
      expect(game.win?(:X)).to be true
    end

    it "returns true if a token has achieved a front diagonal win" do
      generate_board_from("20416", game)
      expect(game.win?(:X)).to be true
    end

    it "returns true if a token has achieved a horizonatal win" do
      generate_board_from("08172", game)
      expect(game.win?(:X)).to be true
    end

    it "returns true if a token has achieved a vertical win" do
      generate_board_from("08376", game)
      expect(game.win?(:X)).to be true
    end
  end

  def generate_board_from(string, game)
    string.each_char do |char|
      move = char.to_i
      game.place(move)
    end
  end
end
