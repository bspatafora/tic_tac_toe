require 'tic_tac_toes/spec_helper'
require 'tic_tac_toes/history'

describe TicTacToes::History do
  let(:database_wrapper)  { double("database wrapper", :record_game_history => true) }
  let(:history)           { TicTacToes::History.new(database_wrapper) }

  describe '#record_board_size' do
    it "records the passed board size" do
      board_size = 9

      history.record_board_size(board_size)
      expect(history.board_size).to eq(board_size)
    end
  end

  describe '#record_move' do
    it "records the passed token and space" do
      move = ["X", 0]

      history.record_move(move)
      expect(history.moves.first).to eql(move)
    end
  end

  describe '#record_winner' do
    it "records the passed winner" do
      token = "O"

      history.record_winner(token)
      expect(history.winner).to eq(token)
    end
  end

  describe '#persist' do
    it "sends the history instance to its database interface for storage" do
      expect(database_wrapper).to receive(:record_game_history).with history
      history.persist
    end
  end
end
