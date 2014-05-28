require 'spec_helper'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/stringifier'

describe TicTacToe::CommandLineIO do
  let(:stringifier) { TicTacToe::Stringifier }
  let(:io) { TicTacToe::CommandLineIO }


  describe '#get_row_size' do
    it "prints a row size solicitation" do
      valid_row_size = 3
      allow(io).to receive(:get_input) { valid_row_size }

      expect(io).to receive(:row_size_solicitation)
      io.get_row_size
    end

    it "gets row size input from the user" do
      valid_row_size = 3
      allow(io).to receive(:row_size_solicitation)

      expect(io).to receive(:get_input) { valid_row_size }
      io.get_row_size
    end

    it "only returns a row size (converted to integer) once it gets integer-like input" do
      not_integer_like, integer_like = "string", "10"
      allow(io).to receive(:row_size_solicitation)
      allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)

      expect(io.get_row_size).to eql(10)
    end
  end


  describe '#row_size_solicitation' do
    it "asks for a row size solicitation string" do
      expect(stringifier).to receive(:row_size_solicitation)
      io.row_size_solicitation
    end
  end


  describe '#get_token' do
    let(:token) { "X" }
    let(:player) { double("player") }

    it "prints a token solicitation with the name of the player whose token is to be set" do
      allow(io).to receive(:get_input) { token }

      expect(io).to receive(:token_solicitation).with(player)
      io.get_token(player)
    end

    it "gets token input from the user" do
      allow(io).to receive(:token_solicitation)

      expect(io).to receive(:get_input) { token }
      io.get_token(player)
    end

    it "returns the input converted into a symbol" do
      token = "O"
      allow(io).to receive(:get_input) { token }
      allow(io).to receive(:token_solicitation)

      expect(io.get_token(player)).to equal(:O)
    end
  end


  describe '#token_solicitation' do
    it "asks for a token solicitation string with the name of the player whose token is to be set" do
      player = :human

      expect(stringifier).to receive(:token_solicitation).with(player)
      io.token_solicitation(player)
    end
  end


  describe '#get_difficulty' do
    let(:difficulty) { "medium" }

    it "prints a difficulty solicitation" do
      allow(io).to receive(:get_input) { difficulty }

      expect(io).to receive(:difficulty_solicitation)
      io.get_difficulty
    end

    it "gets difficulty input from the user" do
      allow(io).to receive(:difficulty_solicitation)

      expect(io).to receive(:get_input) { difficulty }
      io.get_difficulty
    end

    it "returns the input converted into a symbol" do
      difficulty = "hard"
      allow(io).to receive(:get_input) { difficulty }
      allow(io).to receive(:difficulty_solicitation)

      expect(io.get_difficulty).to equal(:hard)
    end
  end


  describe '#difficulty_solicitation' do
    it "asks for a difficulty solicitation string" do
      expect(stringifier).to receive(:difficulty_solicitation)
      io.difficulty_solicitation
    end
  end


  describe '#make_move' do
    let(:board) { double("board") }
    let(:players) { double("players") }

    it "prints a move solicitation" do
      valid_move = 0
      allow(io).to receive(:get_input) { valid_move }

      expect(io).to receive(:move_solicitation)
      io.make_move(board, players)
    end

    it "gets move input from the user" do
      valid_move = 0
      allow(io).to receive(:move_solicitation)

      expect(io).to receive(:get_input) { valid_move }
      io.make_move(board, players)
    end

    it "only returns a move (converted to an integer) once it gets integer-like input" do
      not_integer_like, integer_like = "string", "100"
      allow(io).to receive(:move_solicitation)
      allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)

      expect(io.make_move(board, players)).to eql(100)
    end
  end


  describe '#move_solicitation' do
    it "asks for a move solicitation string" do
      expect(stringifier).to receive(:move_solicitation)
      io.move_solicitation
    end
  end


  describe '#game_over_notification' do
    it "asks for a game over string with the name of the winner" do
      winner = :O

      expect(stringifier).to receive(:game_over_notification).with(winner)
      io.game_over_notification(winner)
    end

    it "asks for a game over string with 'Nobody' if winner is nil" do
      winner = nil
      winner_string = "Nobody"

      expect(stringifier).to receive(:game_over_notification).with(winner_string)
      io.game_over_notification(winner)
    end
  end


  describe '#draw_board' do
    it "asks for the string representation of a board" do
      board = double("board")

      expect(stringifier).to receive(:board).with(board)
      io.draw_board(board)
    end
  end
end
