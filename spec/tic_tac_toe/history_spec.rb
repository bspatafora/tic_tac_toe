require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/history'

describe TicTacToe::History do
  let(:history) { TicTacToe::History.new }

  describe '#record_board_size' do
    it "records the passed board size" do
      board_size = 9

      history.record_board_size(board_size)
      expect(history.board_size).to eql(board_size)
    end
  end

  describe '#record_move' do
    it "records the passed token and space" do
      move = ["X", 0]

      history.record_move(move.first, move.last)
      expect(history.moves.first).to eql(move)
    end
  end

  describe '#record_winner' do
    it "records the passed winner" do
      token = "O"

      history.record_winner(token)
      expect(history.winner).to eql(token)
    end
  end
end
