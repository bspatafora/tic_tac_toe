require 'spec_helper'
require 'tic_tac_toe/command_line_io'

describe TicTacToe::CommandLineIO do
  let(:stringifier) { TicTacToe::Stringifier }
  let(:io) { TicTacToe::CommandLineIO }


  describe '#get_initial_game_state' do
    it "asks for a player array" do
      expect(io).to receive(:get_player_array)
      io.get_initial_game_state
    end

    it "returns a hash containing a board object and a player array" do
      allow(io).to receive(:get_player_array) { [] }
      game_state = io.get_initial_game_state
      expect(game_state[:board]).to be_a TicTacToe::Board
      expect(game_state[:players]).to be_an Array
    end
  end


  describe '#get_player_array' do
    it "returns a player array" do
      human_token, computer_token = :X, :O
      computer_difficulty = :medium

      allow(io).to receive(:get_token).and_return(human_token, computer_token)
      allow(io).to receive(:get_difficulty).and_return(computer_difficulty)

      player_array = io.get_player_array
      expect(player_array).to be_an Array
      player_array.each { |player| expect(player).to be_a TicTacToe::Player }
    end
  end


  describe '#get_human_player' do
    it "gets a token" do
      token, taken_tokens = :X, []
      expect(io).to receive(:get_token).with(:human) { token }
      io.get_human_player(taken_tokens)
    end

    it "only returns a human player once it receives a valid token" do
      invalid_token, valid_token = :invalid, :X
      taken_tokens = []
      allow(io).to receive(:get_token).and_return(invalid_token, valid_token)
      human_player = io.get_human_player(taken_tokens)
      expect(human_player.token).to equal(:X)
    end
  end


  describe '#get_computer_player' do
    it "gets a token" do
      token, taken_tokens = :O, []
      difficulty = :medium
      allow(io).to receive(:get_difficulty) { difficulty }
      expect(io).to receive(:get_token).with(:computer) { token }
      io.get_computer_player(taken_tokens)
    end

    it "only returns a computer player once it receives a valid token and difficulty" do
      invalid_token, valid_token = :invalid, :O
      invalid_difficulty, valid_difficulty = :green, :medium
      taken_tokens = []

      allow(io).to receive(:get_token).and_return(invalid_token, valid_token, valid_token)
      allow(io).to receive(:get_difficulty).and_return(valid_difficulty, invalid_difficulty, valid_difficulty)
      computer_player = io.get_computer_player(taken_tokens)
      expect(computer_player.token).to equal(:O)
      expect(computer_player.decider).to equal(TicTacToe::MediumAI)
    end
  end


  describe '#get_token' do
    let(:token) { "X" }
    let(:player) { double("player") }

    it "asks for a token" do
      allow(io).to receive(:solicit_input) { token }
      expect(io).to receive(:ask_for_token).with(player)
      io.get_token(player)
    end

    it "solicits token input" do
      allow(io).to receive(:ask_for_token)
      expect(io).to receive(:solicit_input) { token }
      io.get_token(player)
    end

    it "converts the input into a symbol" do
      allow(io).to receive(:solicit_input) { token }
      allow(io).to receive(:ask_for_token)
      expect(io.get_token(player)).to equal(:X)
    end
  end


  describe '#ask_for_token' do
    it "asks for a stringified token solicitation message" do
      player = :human
      expect(stringifier).to receive(:stringify_ask_for_token).with(player)
      io.ask_for_token(player)
    end
  end


  describe '#get_difficulty' do
    let(:difficulty) { "medium" }

    it "asks for a difficulty" do
      allow(io).to receive(:solicit_input) { difficulty }
      expect(io).to receive(:ask_for_difficulty)
      io.get_difficulty
    end

    it "solicits difficulty input" do
      allow(io).to receive(:ask_for_difficulty)
      expect(io).to receive(:solicit_input) { difficulty }
      io.get_difficulty
    end

    it "converts the input into a symbol" do
      allow(io).to receive(:solicit_input) { difficulty }
      allow(io).to receive(:ask_for_difficulty)
      expect(io.get_difficulty).to equal(:medium)
    end
  end


  describe '#ask_for_difficulty' do
    it "asks for a stringified difficulty solicitation message" do
      expect(stringifier).to receive(:stringify_ask_for_difficulty)
      io.ask_for_difficulty
    end
  end


  describe '#make_move' do
    let(:board) { double("board") }
    let(:players) { double("players") }

    it "asks for a move" do
      valid_move = 0
      allow(io).to receive(:solicit_input) { valid_move }
      expect(io).to receive(:ask_for_move)
      io.make_move(board, players)
    end

    it "solicits move input" do
      valid_move = 0
      allow(io).to receive(:ask_for_move)
      expect(io).to receive(:solicit_input) { valid_move }
      io.make_move(board, players)
    end

    it "only returns a move once it receives an integer-like string" do
      not_integer_like, integer_like = "string", 100
      allow(io).to receive(:ask_for_move)
      allow(io).to receive(:solicit_input).and_return(not_integer_like, integer_like)
      expect(io.make_move(board, players)).to eql(integer_like)
    end
  end


  describe '#ask_for_move' do
    it "asks for a stringified move solicitation message" do
      expect(stringifier).to receive(:stringify_ask_for_move)
      io.ask_for_move
    end
  end


  describe '#say_game_over' do
    it "asks for a stringified game over message" do
      winner = :O
      expect(stringifier).to receive(:stringify_game_over).with(winner)
      io.say_game_over(winner)
    end

    it "passes 'Nobody' if there is no winner" do
      winner = nil
      winner_string = "Nobody"
      expect(stringifier).to receive(:stringify_game_over).with(winner_string)
      io.say_game_over(winner)
    end
  end


  describe '#draw_board' do
    it "asks for a stringified representation of a board" do
      board = double("board")
      expect(stringifier).to receive(:stringify_board).with(board)
      io.draw_board(board)
    end
  end
end
