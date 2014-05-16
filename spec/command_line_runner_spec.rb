require 'spec_helper'
require 'tic_tac_toe/command_line_runner'

describe TicTacToe::CommandLineRunner do
  end_state_board = [:X, nil, nil,
                     nil, :X, nil,
                     nil, nil, :X]
  let(:board) { generate_board(end_state_board) }

  let(:human_player) { double("human player", :token => :X, :make_move => true) }
  let(:computer_player) { double("computer player", :token => :O, :make_move => true) }
  let(:players) { [human_player, computer_player] }

  let(:runner) { TicTacToe::CommandLineRunner.new(board, players) }
  let(:io) { TicTacToe::CommandLineIO }


  describe '#run' do
    it "ends the game when it is over" do
      allow(io).to receive(:draw_board)
      expect(runner).to receive(:end_game)
      runner.run
    end
  end


  describe '#take_turn' do
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
