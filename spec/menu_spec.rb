require 'spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/menu'

describe TicTacToe::Menu do
  let(:io) { TicTacToe::CommandLineIO }
  let(:menu) { TicTacToe::Menu.new }

  describe '#get_initial_game_state' do
    it "gets players" do
      allow(menu).to receive(:get_board)

      expect(menu).to receive(:get_players)
      menu.get_initial_game_state
    end

    it "gets a board" do
      allow(menu).to receive(:get_players)

      expect(menu).to receive(:get_board)
      menu.get_initial_game_state
    end

    it "returns a hash containing a board object and a player array" do
      row_size = 3
      human_token, computer_token = :X, :O
      difficulty = :medium

      allow(io).to receive(:get_row_size) { row_size }
      allow(io).to receive(:get_token).and_return(human_token, computer_token)
      allow(io).to receive(:get_difficulty) { difficulty }

      game_state = menu.get_initial_game_state
      expect(game_state[:board]).to be_a TicTacToe::Board
      expect(game_state[:players]).to be_an Array
    end
  end


  describe '#get_board' do
    it "returns a board with the correct row size when given valid row size input" do
      row_size = 3
      allow(io).to receive(:get_row_size) { row_size }

      board = menu.get_board
      expect(board.row_size).to equal(row_size)
    end

    it "only returns a board once it receives a valid row size" do
      invalid_row_size, valid_row_size = 999, 5
      allow(io).to receive(:get_row_size).and_return(invalid_row_size, valid_row_size)

      board = menu.get_board
      expect(board.row_size).to equal(valid_row_size)
    end
  end


  describe '#get_players' do
    it "returns an array consisting of a human player and a computer player" do
      human_token, computer_token = :X, :O
      difficulty = :medium

      allow(io).to receive(:get_token).and_return(human_token, computer_token)
      allow(io).to receive(:get_difficulty).and_return(difficulty)

      human_player, computer_player = menu.get_players
      expect(human_player.decider).to eql(TicTacToe::CommandLineIO)
      expect(computer_player.decider).to eql(TicTacToe::MediumAI)
    end
  end


  describe '#get_human_player' do
    it "gets a token for the human player" do
      token, taken_tokens = :X, []

      expect(io).to receive(:get_token).with(:human) { token }
      menu.get_human_player(taken_tokens)
    end

    it "only returns a human player once it receives a valid token" do
      invalid_token, valid_token = :invalid, :X
      taken_tokens = []

      allow(io).to receive(:get_token).and_return(invalid_token, valid_token)
      human_player = menu.get_human_player(taken_tokens)
      expect(human_player.token).to equal(valid_token)
    end
  end


  describe '#get_computer_player' do
    it "gets a token for the computer player" do
      token, taken_tokens = :O, []
      difficulty = :medium
      allow(io).to receive(:get_difficulty) { difficulty }

      expect(io).to receive(:get_token).with(:computer) { token }
      menu.get_computer_player(taken_tokens)
    end

    it "gets a difficulty for the computer player" do
      token, taken_tokens = :O, []
      difficulty = :medium
      allow(io).to receive(:get_token).with(:computer) { token }

      expect(io).to receive(:get_difficulty) { difficulty }
      menu.get_computer_player(taken_tokens)
    end

    it "only returns a computer player once it receives a valid token and difficulty" do
      invalid_token, valid_token = :invalid, :O
      invalid_difficulty, valid_difficulty = :invalid, :medium
      taken_tokens = []

      allow(io).to receive(:get_token).
        and_return(invalid_token, valid_token, valid_token)
      allow(io).to receive(:get_difficulty).
        and_return(valid_difficulty, invalid_difficulty, valid_difficulty)
      computer_player = menu.get_computer_player(taken_tokens)
      expect(computer_player.token).to equal(valid_token)
      expect(computer_player.decider).to equal(TicTacToe::MediumAI)
    end
  end
end
