require 'spec_helper'
require 'tic_tac_toe/rules'

describe TicTacToe::Rules do
  let(:rules) { TicTacToe::Rules }


  describe '#row_size_valid?' do
    it "returns false if the row size is outside the range 2 to 10" do
      invalid_row_size = 11

      expect(rules.row_size_valid?(invalid_row_size)).to be false
    end

    it "returns true if the row size is in the range 2 to 10" do
      valid_row_size = 10

      expect(rules.row_size_valid?(valid_row_size)).to be true
    end
  end


  describe '#token_valid?' do
    it "returns false if the token is not a single character" do
      long_token, taken_tokens = :long, []

      expect(rules.token_valid?(long_token, taken_tokens)).to be false
    end

    it "returns false if the token is already taken" do
      taken_token, taken_tokens = :X, [:X]

      expect(rules.token_valid?(taken_token, taken_tokens)).to be false
    end

    it "returns true if the token is a single character and untaken" do
      valid_token, taken_tokens = :O, [:X]

      expect(rules.token_valid?(valid_token, taken_tokens)).to be true
    end
  end


  describe '#difficulty_valid?' do
    it "returns false if the difficulty is not a key in AI_DIFFICULTIES" do
      invalid_difficulty = :invalid

      expect(rules.difficulty_valid?(invalid_difficulty)).to be false
    end

    it "returns true if the difficulty is a key in AI_DIFFICULTIES" do
      valid_difficulty = :medium

      expect(rules.difficulty_valid?(valid_difficulty)).to be true
    end
  end


  describe '#game_over?' do
    let(:human_player) { double("human player", token: :X) }
    let(:computer_player) { double("computer player", token: :O) }
    let(:players) { [human_player, computer_player] }

    it "returns false if there is not yet a winner and the board is not full" do
      structure = [:X, :X,  :O,
                   :O, :O, nil,
                   :X, :O,  :X]
      board = generate_board(structure)

      expect(rules.game_over?(board, players)).to be false
    end

    it "returns true if any player has won" do
      structure = [ :X, nil, nil,
                   nil,  :X, nil,
                   nil, nil,  :X]
      board = generate_board(structure)

      expect(rules.game_over?(board, players)).to be true
    end

    it "returns true if the board is full" do
      structure = [:X, :X, :O,
                   :O, :O, :X,
                   :X, :O, :X]
      board = generate_board(structure)

      expect(rules.game_over?(board, players)).to be true
    end
  end


  describe '#determine_winner' do
    let(:human_player) { double("human player", token: :X) }
    let(:computer_player) { double("computer player", token: :O) }
    let(:players) { [human_player, computer_player] }

    it "returns the winning token when there is a winner" do
      structure = [ :O, nil, nil,
                   nil,  :O, nil,
                   nil, nil,  :O]
      board = generate_board(structure)
      winning_token = :O

      expect(rules.determine_winner(board, players)).to eql(winning_token)
    end

    it "returns nil if there is not a winner" do
      structure = [:X, :X,  :O,
                   :O, :O, nil,
                   :X, :O,  :X]
      board = generate_board(structure)

      expect(rules.determine_winner(board, players)).to be_nil
    end
  end


  describe '#win?' do
    it "returns false if the given token has not won" do
      structure = [:X, :X,  :O,
                   :O, :O, nil,
                   :X, :O,  :X]
      board = generate_board(structure)

      expect(rules.win?(board, :X)).to be false
    end

    it "returns true if the given token has achieved a back diagonal win" do
      structure = [ :X, nil, nil,
                   nil,  :X, nil,
                   nil, nil,  :X]
      board = generate_board(structure)

      expect(rules.win?(board, :X)).to be true
    end

    it "returns true if the given token has achieved a front diagonal win" do
      structure = [nil, nil,  :X,
                   nil,  :X, nil,
                    :X, nil, nil]
      board = generate_board(structure)

      expect(rules.win?(board, :X)).to be true
    end

    it "returns true if the given token has achieved a horizonatal win" do
      structure = [nil, nil, nil,
                    :X,  :X,  :X,
                   nil, nil, nil]
      board = generate_board(structure)

      expect(rules.win?(board, :X)).to be true
    end

    it "returns true if the given token has achieved a vertical win" do
      structure = [nil, :X, nil,
                   nil, :X, nil,
                   nil, :X, nil]
      board = generate_board(structure)

      expect(rules.win?(board, :X)).to be true
    end
  end
end
