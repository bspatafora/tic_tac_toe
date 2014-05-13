require 'spec_helper'

describe TicTacToe::Game do
  let(:board) { TicTacToe::Board.new }
  let(:game) { TicTacToe::Game.new(board) }

  describe '#make_move' do
    it "sends the move to its board object" do
      expect(board).to receive(:place).with(0, :X)
      game.make_move(0)
    end

    it "rotates the tokens after a move" do
      game.make_move(0)
      expect(game.tokens.first).to eql(:O)
    end
  end

  describe '#over?' do
    it "returns false if the game is not over" do
      generate_board_from("04871263", game)
      expect(game.over?).to be false
    end

    it "returns true if there is a winner" do
      generate_board_from("706458", game)
      expect(game.over?).to be_true
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
      space = char.to_i
      game.make_move(space)
    end
  end
end
