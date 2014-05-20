require 'spec_helper'
require 'tic_tac_toe/command_line_io'

describe TicTacToe::CommandLineIO do
  let(:stringifier) { TicTacToe::Stringifier }
  let(:io) { TicTacToe::CommandLineIO }


  describe '#make_move' do
    let(:board) { double("board") }
    let(:human_player) { double("human player", :token => :X) }
    let(:computer_player) { double("computer player", :token => :O) }
    let(:players) { [human_player, computer_player] }

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


  describe '#get_token' do
    let(:player) { :human }

    it "asks for a token" do
      valid_token = "X"
      allow(io).to receive(:solicit_input) { valid_token }
      expect(io).to receive(:ask_for_token).with(player)
      io.get_token(player)
    end

    it "solicits token input" do
      valid_token = "X"
      allow(io).to receive(:ask_for_token)
      expect(io).to receive(:solicit_input) { valid_token }
      io.get_token(player)
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
    let(:valid_difficulty) { "easy" }
    let(:invalid_difficulty) { "green" }

    it "asks for a difficulty" do
      allow(io).to receive(:solicit_input) { valid_difficulty }
      expect(io).to receive(:ask_for_difficulty)
      io.get_difficulty
    end

    it "solicits difficulty input" do
      allow(io).to receive(:ask_for_difficulty)
      expect(io).to receive(:solicit_input) { valid_difficulty }
      io.get_difficulty
    end

    it "only returns a difficulty once it receives a valid string" do
      allow(io).to receive(:ask_for_difficulty)
      allow(io).to receive(:solicit_input).and_return(invalid_difficulty, valid_difficulty)
      expect(io.get_difficulty).to eql(:easy)
    end
  end


  describe '#ask_for_difficulty' do
    it "asks for a stringified difficulty solicitation message" do
      expect(stringifier).to receive(:stringify_ask_for_difficulty)
      io.ask_for_difficulty
    end
  end


  describe '#say_game_over' do
    it "asks for a stringified game over message" do
      winner = :O
      expect(stringifier).to receive(:stringify_game_over).with(winner)
      io.say_game_over(winner)
    end
  end


  describe '#draw_board' do
    it "asks for a stringified representation of its game's board" do
      board = double("board")
      expect(stringifier).to receive(:stringify_board).with(board)
      io.draw_board(board)
    end
  end
end
