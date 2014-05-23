require 'spec_helper'
require 'tic_tac_toe/menu'

describe TicTacToe::Menu do
  let(:io) { TicTacToe::CommandLineIO }
  let(:menu) { TicTacToe::Menu.new }

  describe '#get_initial_game_state' do
    it "asks for a player array" do
      allow(menu).to receive(:get_board)
      expect(menu).to receive(:get_player_array)
      menu.get_initial_game_state
    end

    it "asks for a board" do
      allow(menu).to receive(:get_player_array)
      expect(menu).to receive(:get_board)
      menu.get_initial_game_state
    end

    it "returns a hash containing a board object and a player array" do
      row_size = 3
      human_token, computer_token = :X, :O
      computer_difficulty = :medium

      allow(io).to receive(:get_row_size) { row_size }
      allow(io).to receive(:get_token).and_return(human_token, computer_token)
      allow(io).to receive(:get_difficulty) { computer_difficulty }

      game_state = menu.get_initial_game_state
      expect(game_state[:board]).to be_a TicTacToe::Board
      expect(game_state[:players]).to be_an Array
    end
  end


  describe '#get_board' do
    it "returns a board" do
      row_size = 3
      board_size = 9
      allow(io).to receive(:get_row_size) { row_size }
      expect(menu.get_board.size).to equal(board_size)
    end

    it "only returns a board once it receives a valid row size" do
      invalid_row_size, valid_row_size = 14, 5
      board_size = valid_row_size ** 2
      allow(io).to receive(:get_row_size).and_return(invalid_row_size, valid_row_size)
      board = menu.get_board
      expect(board.size).to equal(board_size)
    end
  end


  describe '#get_player_array' do
    it "returns a player array" do
      human_token, computer_token = :X, :O
      computer_difficulty = :medium

      allow(io).to receive(:get_token).and_return(human_token, computer_token)
      allow(io).to receive(:get_difficulty).and_return(computer_difficulty)

      player_array = menu.get_player_array
      expect(player_array).to be_an Array
      player_array.each { |player| expect(player).to be_a TicTacToe::Player }
    end
  end


  describe '#get_human_player' do
    it "gets a token" do
      token, taken_tokens = :X, []
      expect(io).to receive(:get_token).with(:human) { token }
      menu.get_human_player(taken_tokens)
    end

    it "only returns a human player once it receives a valid token" do
      invalid_token, valid_token = :invalid, :X
      taken_tokens = []
      allow(io).to receive(:get_token).and_return(invalid_token, valid_token)
      human_player = menu.get_human_player(taken_tokens)
      expect(human_player.token).to equal(:X)
    end
  end


  describe '#get_computer_player' do
    it "gets a token" do
      token, taken_tokens = :O, []
      difficulty = :medium
      allow(io).to receive(:get_difficulty) { difficulty }
      expect(io).to receive(:get_token).with(:computer) { token }
      menu.get_computer_player(taken_tokens)
    end

    it "only returns a computer player once it receives a valid token and difficulty" do
      invalid_token, valid_token = :invalid, :O
      invalid_difficulty, valid_difficulty = :green, :medium
      taken_tokens = []

      allow(io).to receive(:get_token).and_return(invalid_token, valid_token, valid_token)
      allow(io).to receive(:get_difficulty).and_return(valid_difficulty, invalid_difficulty, valid_difficulty)
      computer_player = menu.get_computer_player(taken_tokens)
      expect(computer_player.token).to equal(:O)
      expect(computer_player.decider).to equal(TicTacToe::MediumAI)
    end
  end
end
