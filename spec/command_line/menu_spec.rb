require 'tic_tac_toes/io'
require 'command_line/menu'
require 'tic_tac_toes/move_strategies/human'
require 'tic_tac_toes/move_strategies/medium_ai'

describe CommandLine::Menu do
  let(:prompt) { double("prompt") }
  let(:io) { TicTacToes::IO.new(prompt) }
  let(:menu) { CommandLine::Menu.new(io) }


  describe '#get_board' do
    let(:invalid_row_size) { 11 }
    let(:valid_row_size) { 7 }

    it "displays an invalid row size error when given an invalid (outside 2-10) row size" do
      allow(io).to receive(:get_row_size).and_return(invalid_row_size, valid_row_size)

      expect(io).to receive(:invalid_row_size_error)
      menu.get_board
    end

    it "only returns a row size once it receives a valid (2-10) row size" do
      allow(io).to receive(:invalid_row_size_error)
      allow(io).to receive(:get_row_size).and_return(invalid_row_size, valid_row_size)

      board = menu.get_board
      expect(board.row_size).to eq(valid_row_size)
    end
  end


  describe '#get_players' do
    it "returns an array with a human (IO move_strategy) player and a computer (AI move_strategy) player" do
      first_token, second_token = "X", "O"
      difficulty = :medium

      allow(io).to receive(:get_token).and_return(first_token, second_token)
      allow(io).to receive(:get_difficulty).and_return(difficulty)

      human_player, computer_player = menu.get_players
      expect(human_player.move_strategy).to be_a TicTacToes::MoveStrategies::Human
      expect(computer_player.move_strategy).to eq(TicTacToes::MoveStrategies::MediumAI)
    end

    context 'when given an invalid (non-single-character) token' do
      let(:invalid_token) { "invalid" }
      let(:first_token) { "X" }
      let(:second_token) { "O" }

      before(:each) do
        valid_difficulty = :medium
        allow(io).to receive(:get_difficulty) { valid_difficulty }
      end

      it "displays an invalid token error" do
        allow(io).to receive(:get_token).and_return(invalid_token, first_token, second_token)

        expect(io).to receive(:invalid_token_error)
        menu.get_players
      end

      it "only returns an array of players (with correct tokens) once it receives a valid token" do
        allow(io).to receive(:invalid_token_error)
        allow(io).to receive(:get_token).and_return(invalid_token, first_token, second_token)

        first_player, second_player = menu.get_players
        expect(first_player.token).to eq(first_token)
        expect(second_player.token).to eq(second_token)
      end
    end

    context 'when given an invalid (not in the list) difficulty' do
      let(:invalid_difficulty) { :invalid }
      let(:valid_difficulty) { :medium }

      before(:each) do
        first_token, second_token = "X", "O"
        allow(io).to receive(:get_token).and_return(first_token, second_token)
      end

      it "displays an invalid difficulty error" do
        allow(io).to receive(:get_difficulty).and_return(invalid_difficulty, valid_difficulty)

        expect(io).to receive(:invalid_difficulty_error)
        menu.get_players
      end

      it "only returns an array of players (with correct difficulty) once it receives a valid difficulty" do
        allow(io).to receive(:invalid_difficulty_error)
        allow(io).to receive(:get_difficulty).and_return(invalid_difficulty, valid_difficulty)

        computer_player = menu.get_players.last
        expect(computer_player.move_strategy).to eq(TicTacToes::MoveStrategies::MediumAI)
      end
    end
  end
end
