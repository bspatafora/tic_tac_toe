require 'tic_tac_toes/test_board_generator'
require 'tic_tac_toes/core/rules'

describe TicTacToes::Core::Rules do
  let(:rules) { TicTacToes::Core::Rules }
  let(:x) { double("human player", token: "x") }
  let(:o) { double("computer player", token: "o") }
  let(:players) { [x, o] }

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
    it "returns false if there is not yet a winner and the board is not full" do
      board = TicTacToes::TestBoardGenerator.generate([x, x,   o,
                                                       o, o, nil,
                                                       x, o,   x])

      expect(rules.game_over?(board, players)).to be false
    end

    it "returns true if any player has won" do
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil,   x, nil,
                                                       nil, nil,   x])

      expect(rules.game_over?(board, players)).to be true
    end

    it "returns true if the board is full" do
      board = TicTacToes::TestBoardGenerator.generate([x, x, o,
                                                       o, o, x,
                                                       x, o, x])

      expect(rules.game_over?(board, players)).to be true
    end
  end


  describe '#determine_winner' do
    it "returns the winning player when there is a winner" do
      board = TicTacToes::TestBoardGenerator.generate([  o, nil, nil,
                                                       nil,   o, nil,
                                                       nil, nil,   o])
      winning_token = "o"

      winning_player = rules.determine_winner(board, players)
      expect(winning_player.token).to eql(winning_token)
    end

    it "returns nil if there is not a winner" do
      board = TicTacToes::TestBoardGenerator.generate([x, x,   o,
                                                       o, o, nil,
                                                       x, o,   x])

      expect(rules.determine_winner(board, players)).to be_nil
    end
  end


  describe '#win?' do
    it "returns false if the given token has not won" do
      board = TicTacToes::TestBoardGenerator.generate([x, x,  o,
                                                       o, o, nil,
                                                       x, o,  x])

      expect(rules.win?(board, x)).to be false
    end

    it "returns true if the given token has achieved a back diagonal win" do
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil,   x, nil,
                                                       nil, nil,   x])

      expect(rules.win?(board, x)).to be true
    end

    it "returns true if the given token has achieved a front diagonal win" do
      board = TicTacToes::TestBoardGenerator.generate([nil, nil,   x,
                                                       nil,   x, nil,
                                                         x, nil, nil])

      expect(rules.win?(board, x)).to be true
    end

    it "returns true if the given token has achieved a horizonatal win" do
      board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         x,   x,   x,
                                                       nil, nil, nil])

      expect(rules.win?(board, x)).to be true
    end

    it "returns true if the given token has achieved a vertical win" do
      board = TicTacToes::TestBoardGenerator.generate([nil, x, nil,
                                                       nil, x, nil,
                                                       nil, x, nil])

      expect(rules.win?(board, x)).to be true
    end
  end
end
