require 'spec_helper'
require 'tic_tac_toe/command_line_runner'

describe TicTacToe::CommandLineRunner do
  let(:io) { TicTacToe::CommandLineIO }

  let(:human_player) { double("human player", :token => :X, :make_move => true) }
  let(:computer_player) { double("computer player", :token => :O, :make_move => true) }
  let(:players) { [human_player, computer_player] }

  let(:board) { double("board") }
  let(:runner) { TicTacToe::CommandLineRunner.new(board) }


  describe '#run' do
    end_state_structure = [:X, nil, nil,
                           nil, :X, nil,
                           nil, nil, :X]
    let(:end_state_board) { generate_board(end_state_structure) }
    let(:end_state_runner) { TicTacToe::CommandLineRunner.new(end_state_board) }

    it "generates the players" do
      allow(end_state_runner).to receive(:end_game)
      expect(end_state_runner).to receive(:generate_players) { players }
      end_state_runner.run
    end

    it "takes turns" do
      allow(runner).to receive(:generate_players) { players }
      allow(TicTacToe::Rules).to receive(:game_over?).and_return(false, true)
      allow(runner).to receive(:end_game)
      expect(runner).to receive(:take_turn).once
      runner.run
    end

    it "ends the game when it is over" do
      allow(end_state_runner).to receive(:generate_players) { players }
      allow(io).to receive(:draw_board)
      expect(end_state_runner).to receive(:end_game)
      end_state_runner.run
    end
  end


  describe '#generate_players' do
    let(:player) { double("player", :token => :X) }

    it "asks for two generated players" do
      expect(runner).to receive(:generate_player).twice { player }
      runner.generate_players
    end
  end


  describe '#generate_player' do
    let(:taken_tokens) { [:X] }
    let(:player) { runner.generate_player(double("player type"), double("decider"), taken_tokens) }

    it "asks until it receives a valid token" do
      invalid_token, valid_token = taken_tokens.first, :O
      allow(io).to receive(:get_token).and_return(invalid_token, valid_token)
      expect(player.token).to eql(:O)
    end
  end


  describe '#take_turn' do
    before(:each) do
      allow(runner).to receive(:generate_players) { players }
      allow(TicTacToe::Rules).to receive(:game_over?) { true }
      allow(runner).to receive(:end_game)
      runner.run
    end

    it "asks the interface to draw the board" do
      expect(io).to receive(:draw_board)
      runner.take_turn
    end

    it "asks the current player to make a move" do
      allow(io).to receive(:draw_board)
      expect(human_player).to receive(:make_move)
      runner.take_turn
    end

    it "keeps track of the current player" do
      allow(io).to receive(:draw_board)
      allow(human_player).to receive(:make_move)
      runner.take_turn
      expect(computer_player).to receive(:make_move)
      runner.take_turn
    end
  end


  describe '#end_game' do
    it "asks the interface to draw the board" do
      allow(io).to receive(:say_game_over)
      expect(io).to receive(:draw_board)
      runner.end_game
    end

    it "asks the interface to say game over" do
      allow(io).to receive(:draw_board)
      expect(io).to receive(:say_game_over)
      runner.end_game
    end
  end
end
