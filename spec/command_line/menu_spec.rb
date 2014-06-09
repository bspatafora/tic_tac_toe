require 'command_line/io'
require 'command_line/menu'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/stringifier'

describe CommandLine::Menu do
  let(:io) { CommandLine::IO }
  let(:stringifier) { TicTacToe::Stringifier }
  let(:menu) { CommandLine::Menu.new(io) }


  describe '#get_board' do
    it "returns a board with the correct row size when given valid row size input" do
      row_size = 3
      allow(io).to receive(:get_row_size) { row_size }

      board = menu.get_board
      expect(board.row_size).to equal(row_size)
    end
  end


  describe '#get_row_size' do
    it "returns the row size it receives from its IO" do
      row_size = 3
      allow(io).to receive(:get_row_size) { row_size }

      expect(menu.get_row_size).to equal(row_size)
    end

    context 'when given an invalid row size (outside the range 2 to 10)' do
      let(:invalid_row_size) { 99 }
      let(:valid_row_size) { 5 }

      it "sends an invalid row size error" do
        allow(io).to receive(:get_row_size).and_return(invalid_row_size, valid_row_size)

        expect(io).to receive(:invalid_row_size_error)
        menu.get_row_size
      end

      it "only returns a row size once it receives a valid row size" do
        allow(io).to receive(:invalid_row_size_error)
        allow(io).to receive(:get_row_size).and_return(invalid_row_size, valid_row_size)

        expect(menu.get_row_size).to equal(valid_row_size)
      end
    end
  end


  describe '#get_players' do
    it "returns an array consisting of a human player and a computer player" do
      human_token, computer_token = "X", "O"
      difficulty = :medium

      allow(io).to receive(:get_token).and_return(human_token, computer_token)
      allow(io).to receive(:get_difficulty).and_return(difficulty)

      human_player, computer_player = menu.get_players
      expect(human_player.decider).to eql(CommandLine::IO)
      expect(computer_player.decider).to eql(TicTacToe::MediumAI)
    end
  end


  describe '#get_token' do
    it "asks for a token with the name of the player whose token it will be" do
      player = :human
      token, taken_tokens = "X", []

      expect(io).to receive(:get_token).with(player) { token }
      menu.get_token(player, taken_tokens)
    end

    it "returns the token it receives from its IO" do
      player = :human
      token, taken_tokens = "X", []
      allow(io).to receive(:get_token).with(player) { token }

      expect(menu.get_token(player, taken_tokens)).to equal(token)
    end

    context 'when given an invalid token' do
      let(:player) { :human }
      let(:invalid_token) { :invalid }
      let(:valid_token) { "X" }
      let(:taken_tokens) { [] }

      it "sends an invalid token error" do
        allow(io).to receive(:get_token).and_return(invalid_token, valid_token)

        expect(io).to receive(:invalid_token_error)
        menu.get_token(player, taken_tokens)
      end

      it "only returns a token once it receives a valid token" do
        allow(io).to receive(:invalid_token_error)
        allow(io).to receive(:get_token).and_return(invalid_token, valid_token)

        expect(menu.get_token(player, taken_tokens)).to equal(valid_token)
      end
    end
  end


  describe '#get_difficulty' do
    it "asks for a difficulty" do
      difficulty = :medium

      expect(io).to receive(:get_difficulty) { difficulty }
      menu.get_difficulty
    end

    context 'when given an invalid difficulty' do
      let(:invalid_difficulty) { :invalid }
      let(:valid_difficulty) { :medium }

      it "sends an invalid difficulty error" do
        allow(io).to receive(:get_difficulty).and_return(invalid_difficulty, valid_difficulty)

        expect(io).to receive(:invalid_difficulty_error)
        menu.get_difficulty
      end

      it "only returns a difficulty once it receives a valid difficulty" do
        allow(io).to receive(:invalid_difficulty_error)
        allow(io).to receive(:get_difficulty).and_return(invalid_difficulty, valid_difficulty)

        expect(menu.get_difficulty).to equal(valid_difficulty)
      end
    end
  end
end
