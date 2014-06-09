require 'command_line/runner'
require 'tic_tac_toe/spec_helper'

describe CommandLine::Runner do
  let(:io)    { double("IO",
                :draw_board => true,
                :thinking_notification => true,
                :game_over_notification => true) }
  let(:menu)  { double("Menu",
                :get_board => true,
                :get_players => true) }
  let(:rules) { double("Rules",
                :game_over? => true,
                :determine_winner => true) }

  let(:runner) { CommandLine::Runner.new(io, menu, rules) }


  describe '#run' do
    it "asks its menu for a board and players" do
      expect(menu).to receive(:get_board)
      expect(menu).to receive(:get_players)
      runner.run
    end

    it "takes turns until the game is over" do
      allow(rules).to receive(:game_over?).and_return(false, true)

      expect(runner).to receive(:take_turn).once
      runner.run
    end

    it "ends the game when the game is over" do
      expect(runner).to receive(:end_game)
      runner.run
    end
  end


  describe '#take_turn' do
    let(:board) { double("board") }
    let(:first_player) { double("first player", make_move: true, needs_to_think: true) }
    let(:second_player) { double("second player", make_move: true, needs_to_think: false) }
    let(:players) { [first_player, second_player] }

    it "asks its IO to draw the board" do
      expect(io).to receive(:draw_board)
      runner.take_turn(board, players)
    end

    it "sends a thinking notification if the current player needs to think" do
      expect(io).to receive(:thinking_notification)
      runner.take_turn(board, players)

      expect(io).not_to receive(:thinking_notification)
      runner.take_turn(board, players)
    end

    it "asks the first player to make a move" do
      expect(first_player).to receive(:make_move)
      runner.take_turn(board, players)
    end

    it "keeps track of the current player by rotating the players" do
      runner.take_turn(board, players)
      expect(second_player).to receive(:make_move)
      runner.take_turn(board, players)
    end
  end


  describe '#end_game' do
    let(:board) { double("board") }
    let(:players) { double("players") }

    it "asks its IO to draw the board" do
      expect(io).to receive(:draw_board)
      runner.end_game(board, players)
    end

    it "asks its IO to notify the user of the winner" do
      allow(rules).to receive(:determine_winner) { :winner }

      expect(io).to receive(:game_over_notification).with(:winner)
      runner.end_game(board, players)
    end

    it "asks its rules to determine the winner" do
      expect(rules).to receive(:determine_winner)
      runner.end_game(board, players)
    end
  end
end
