require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/command_line/io'
require 'tic_tac_toe/stringifier'

describe TicTacToe::IO do
  let(:stringifier) { TicTacToe::Stringifier }
  let(:io) { TicTacToe::IO }


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

    context 'when given not-integer-like input' do
      let(:not_integer_like) { "string" }
      let(:integer_like) { "100" }

      it "sends a red notification with a not-integer-like message" do
        allow(io).to receive(:move_solicitation)
        allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)

        expect(io).to receive(:red_notification).with(stringifier.not_an_integer)
        io.make_move(board, players)
      end

      it "only returns a move (converted to integer) once it gets integer-like input" do
        allow(io).to receive(:move_solicitation)
        allow(io).to receive(:red_notification)
        allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)

        expect(io.make_move(board, players)).to eql(100)
      end
    end
  end


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

    context 'when given not-integer-like input' do
      let(:not_integer_like) { "string" }
      let(:integer_like) { "10" }

      it "sends a red notification with a not-integer-like message" do
        allow(io).to receive(:row_size_solicitation)
        allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)

        expect(io).to receive(:red_notification).with(stringifier.not_an_integer)
        io.get_row_size
      end

      it "only returns a row size (converted to integer) once it gets integer-like input" do
        allow(io).to receive(:row_size_solicitation)
        allow(io).to receive(:red_notification)
        allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)

        expect(io.get_row_size).to eql(10)
      end
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

    it "returns the input" do
      token = "O"
      allow(io).to receive(:get_input) { token }
      allow(io).to receive(:token_solicitation)

      expect(io.get_token(player)).to equal(token)
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


  describe '#move_solicitation' do
    it "asks for a move solicitation string" do
      expect(stringifier).to receive(:move_solicitation)
      io.move_solicitation
    end
  end


  describe '#row_size_solicitation' do
    it "asks for a row size solicitation string" do
      expect(stringifier).to receive(:row_size_solicitation)
      io.row_size_solicitation
    end
  end


  describe '#token_solicitation' do
    it "asks for a token solicitation string with the name of the player whose token is to be set" do
      player = :human

      expect(stringifier).to receive(:token_solicitation).with(player)
      io.token_solicitation(player)
    end
  end


  describe '#difficulty_solicitation' do
    it "asks for a difficulty solicitation string" do
      expect(stringifier).to receive(:difficulty_solicitation)
      io.difficulty_solicitation
    end
  end


  describe '#draw_board' do
    it "asks for the string representation of a board" do
      board = double("board")

      expect(stringifier).to receive(:board).with(board)
      io.draw_board(board)
    end
  end


  describe '#red_notification' do
    it "prints the message it receives in red" do
      message = "Error"
      red_message = io.red(message)

      expect(io).to receive(:print).with(red_message)
      io.red_notification(message)
    end
  end


  describe '#not_an_integer_error' do
    it "asks for a not-an-integer string" do
      expect(stringifier).to receive(:not_an_integer)
      io.not_an_integer_error
    end

    it "prints a red notification with the string" do
      expect(io).to receive(:red_notification).with(stringifier.not_an_integer)
      io.not_an_integer_error
    end
  end


  describe '#invalid_row_size_error' do
    it "asks for an invalid row size string" do
      expect(stringifier).to receive(:invalid_row_size)
      io.invalid_row_size_error
    end

    it "prints a red notification with the string" do
      expect(io).to receive(:red_notification).with(stringifier.invalid_row_size)
      io.invalid_row_size_error
    end
  end


  describe '#invalid_token_error' do
    it "asks for an invalid token string" do
      expect(stringifier).to receive(:invalid_token)
      io.invalid_token_error
    end

    it "prints a red notification with the string" do
      expect(io).to receive(:red_notification).with(stringifier.invalid_token)
      io.invalid_token_error
    end
  end


  describe '#invalid_difficulty_error' do
    it "asks for an invalid difficulty string" do
      expect(stringifier).to receive(:invalid_difficulty)
      io.invalid_difficulty_error
    end

    it "prints a red notification with the string" do
      expect(io).to receive(:red_notification).with(stringifier.invalid_difficulty)
      io.invalid_difficulty_error
    end
  end


  describe '#invalid_move_error' do
    it "asks for an invalid move string" do
      expect(stringifier).to receive(:invalid_move)
      io.invalid_move_error
    end

    it "prints a red notification with the string" do
      expect(io).to receive(:red_notification).with(stringifier.invalid_move)
      io.invalid_move_error
    end
  end


  describe '#thinking_notification' do
    it "asks for a thinking string" do
      expect(stringifier).to receive(:thinking)
      io.thinking_notification
    end

    it "prints a red notification with the string" do
      expect(io).to receive(:red_notification).with(stringifier.thinking)
      io.thinking_notification
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
end
