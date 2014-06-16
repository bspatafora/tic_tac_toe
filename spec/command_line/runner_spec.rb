require 'command_line/runner'
require 'tic_tac_toes/board'
require 'tic_tac_toes/history'
require 'tic_tac_toes/spec_helper'

describe CommandLine::Runner do
  let(:io_interface)        { double("io interface",
                              :draw_board => true,
                              :thinking_notification => true,
                              :game_over_notification => true) }
  let(:board)               { TicTacToes::Board.new(row_size: 3) }
  let(:menu)                { double("menu",
                              :get_board => board,
                              :get_players => true) }
  let(:rules)               { double("rules",
                              :game_over? => true,
                              :determine_winner => "X") }
  let(:database_interface)  { double("database interface", :record_game_history => true) }
  let(:history)             { TicTacToes::History.new(database_interface) }

  let(:runner)              { CommandLine::Runner.new(io_interface, menu, rules, history) }


  describe '#run' do
    it "gets a board and players" do
      expect(menu).to receive(:get_board)
      expect(menu).to receive(:get_players)
      runner.run
    end

    it "has its history object record the board size" do
      runner.run
      expect(history.board_size).to eq(board.size)
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
    move = ["X", 0]
    let(:board) { double("board") }
    let(:first_player) { double("first player", make_move: move, needs_to_think: true) }
    let(:second_player) { double("second player", make_move: move, needs_to_think: false) }
    let(:players) { [first_player, second_player] }

    it "draws the board" do
      expect(io_interface).to receive(:draw_board)
      runner.take_turn(board, players)
    end

    it "displays a thinking notification if the current player needs to think" do
      expect(io_interface).to receive(:thinking_notification)
      runner.take_turn(board, players)

      expect(io_interface).not_to receive(:thinking_notification)
      runner.take_turn(board, players)
    end

    it "asks the first player to make a move" do
      expect(first_player).to receive(:make_move)
      runner.take_turn(board, players)
    end

    it "has its history object record the move" do
      runner.take_turn(board, players)
      expect(history.moves.first).to eql(move)
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

    it "draws the board" do
      expect(io_interface).to receive(:draw_board)
      runner.end_game(board, players)
    end

    it "determines the winner" do
      expect(rules).to receive(:determine_winner)
      runner.end_game(board, players)
    end

    it "displays the winner" do
      allow(rules).to receive(:determine_winner) { :winner }

      expect(io_interface).to receive(:game_over_notification).with(:winner)
      runner.end_game(board, players)
    end

    it "has its history object record the winner" do
      runner.end_game(board, players)
      expect(history.winner).to eq("X")
    end

    it "has its history object persist the game history" do
      expect(history).to receive(:persist)
      runner.end_game(board, players)
    end
  end
end
