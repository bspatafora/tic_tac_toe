require 'tic_tac_toes/board'
require 'tic_tac_toes/io_interface'
require 'tic_tac_toes/spec_helper'
require 'tic_tac_toes/strings'

describe TicTacToes::IOInterface do
  let(:strings) { TicTacToes::Strings }
  let(:io) { double("io", solicit_input: 0, display: true, display_red: true) }
  let(:io_interface) { TicTacToes::IOInterface.new(io) }


  describe '#make_move' do
    it "displays a move solicitation" do
      expect(io_interface).to receive(:move_solicitation)
      io_interface.make_move("_board", "_players")
    end

    context 'when given not-integer-like input' do
      let(:not_integer_like) { "string" }
      let(:integer_like) { "100" }

      it "displays a not an integer error" do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io_interface).to receive(:not_an_integer_error).once
        io_interface.make_move("_board", "_players")
      end

      it "only returns a move (converted to integer) once it gets integer-like input" do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io_interface.make_move("_board", "_players")).to eq(100)
      end
    end
  end


  describe '#get_row_size' do
    it "displays a row size solicitation" do
      expect(io_interface).to receive(:row_size_solicitation)
      io_interface.get_row_size
    end

    context 'when given not-integer-like input' do
      let(:not_integer_like) { "string" }
      let(:integer_like) { "100" }

      it "displays a not an integer error" do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io_interface).to receive(:not_an_integer_error).once
        io_interface.get_row_size
      end

      it "only returns a row size (converted to integer) once it gets integer-like input" do
        allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)

        expect(io_interface.get_row_size).to eq(100)
      end
    end
  end


  describe '#get_token' do
    let(:player) { double("player") }

    it "displays a token solicitation with the name of the player whose token is to be set" do
      expect(io_interface).to receive(:token_solicitation).with(player)
      io_interface.get_token(player)
    end

    it "returns the user input" do
      token = "X"
      allow(io).to receive(:solicit_input) { token }

      expect(io_interface.get_token(player)).to equal(token)
    end
  end


  describe '#get_difficulty' do
    let(:difficulty) { "HARD" }

    it "displays a difficulty solicitation" do
      allow(io).to receive(:solicit_input) { difficulty }

      expect(io_interface).to receive(:difficulty_solicitation)
      io_interface.get_difficulty
    end

    it "returns the user input (downcased and converted into a symbol)" do
      allow(io).to receive(:solicit_input) { difficulty }

      expect(io_interface.get_difficulty).to equal(:hard)
    end
  end


  describe '#draw_board' do
    it "displays a board string" do
      board = TicTacToes::Board.new
      board_string = strings.board(board)

      expect(io).to receive(:display).with(board_string)
      io_interface.draw_board(board)
    end
  end


  describe '#invalid_row_size_error' do
    it "displays a red invalid row size message" do
      expect(io).to receive(:display_red).with(strings::INVALID_ROW_SIZE)
      io_interface.invalid_row_size_error
    end
  end


  describe '#invalid_token_error' do
    it "displays a red invalid token message" do
      expect(io).to receive(:display_red).with(strings::INVALID_TOKEN)
      io_interface.invalid_token_error
    end
  end


  describe '#invalid_difficulty_error' do
    it "displays a red invalid difficulty message" do
      expect(io).to receive(:display_red).with(strings::INVALID_DIFFICULTY)
      io_interface.invalid_difficulty_error
    end
  end


  describe '#invalid_move_error' do
    it "displays a red invalid move message" do
      expect(io).to receive(:display_red).with(strings::INVALID_MOVE)
      io_interface.invalid_move_error
    end
  end


  describe '#thinking_notification' do
    it "displays a red thinking message" do
      expect(io).to receive(:display_red).with(strings::THINKING)
      io_interface.thinking_notification
    end
  end


  describe '#game_over_notification' do
    it "displays a game over message with the name of the winner" do
      winner = :X
      game_over_message = strings.game_over_notification(winner)

      expect(io).to receive(:display).with(game_over_message)
      io_interface.game_over_notification(winner)
    end
  end


  describe '#red' do
    it "calls its IO's red method with the passed message" do
      expect(io).to receive(:red).with("message")
      io_interface.red("message")
    end
  end


  describe '#blue' do
    it "calls its IO's blue method with the passed message" do
      expect(io).to receive(:blue).with("message")
      io_interface.blue("message")
    end
  end
end
