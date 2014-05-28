require 'spec_helper'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/command_line_runner'
require 'tic_tac_toe/menu'
require 'tic_tac_toe/rules'

describe TicTacToe::CommandLineRunner do
  let(:io) { TicTacToe::CommandLineIO }
  let(:menu) { TicTacToe::Menu.new }
  let(:rules) { TicTacToe::Rules }
  let(:runner) { TicTacToe::CommandLineRunner.new(menu: menu) }


  describe '#run' do
    let(:board) { double("board") }
    let(:players) { double("players") }

    it "asks its menu for a board and players" do
      allow(rules).to receive(:game_over?) { true }
      allow(runner).to receive(:end_game)

      expect(menu).to receive(:get_board) { board }
      expect(menu).to receive(:get_players) { players }
      runner.run
    end

    it "takes turns until the game is over" do
      allow(menu).to receive(:get_board) { board }
      allow(menu).to receive(:get_players) { players }
      allow(rules).to receive(:game_over?).and_return(false, true)
      allow(runner).to receive(:end_game)

      expect(runner).to receive(:take_turn).once
      runner.run
    end

    it "ends the game when the game is over" do
      allow(menu).to receive(:get_board) { board }
      allow(menu).to receive(:get_players) { players }
      allow(rules).to receive(:game_over?) { true }

      expect(runner).to receive(:end_game)
      runner.run
    end
  end


  describe '#take_turn' do
    let(:board) { double("board") }
    let(:first_player) { double("first player", make_move: true) }
    let(:second_player) { double("second player", make_move: true) }
    let(:players) { [first_player, second_player] }

    it "asks its IO to draw the board" do
      expect(io).to receive(:draw_board)
      runner.take_turn(board, players)
    end

    it "asks the first player to make a move" do
      allow(io).to receive(:draw_board)

      expect(first_player).to receive(:make_move)
      runner.take_turn(board, players)
    end

    it "keeps track of the current player by rotating the players" do
      allow(io).to receive(:draw_board)

      runner.take_turn(board, players)
      expect(second_player).to receive(:make_move)
      runner.take_turn(board, players)
    end
  end


  describe '#end_game' do
    let(:board) { double("board") }
    let(:players) { double("players") }

    it "asks its IO to draw the board" do
      allow(io).to receive(:game_over_notification)
      allow(rules).to receive(:determine_winner)

      expect(io).to receive(:draw_board)
      runner.end_game(board, players)
    end

    it "asks its IO to notify the user of the winner" do
      allow(io).to receive(:draw_board)
      allow(rules).to receive(:determine_winner) { :winner }

      expect(io).to receive(:game_over_notification).with(:winner)
      runner.end_game(board, players)
    end

    it "asks its rules to determine the winner" do
      allow(io).to receive(:draw_board)
      allow(io).to receive(:game_over_notification)

      expect(rules).to receive(:determine_winner)
      runner.end_game(board, players)
    end
  end
end
