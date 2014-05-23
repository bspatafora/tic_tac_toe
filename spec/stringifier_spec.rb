require 'spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/stringifier'

describe TicTacToe::Stringifier do
  describe '#stringify_board' do
    it "returns a stringified board" do
      board = TicTacToe::Board.new(row_size: 3)
      board.place(4, :X)
      stringified_board = <<eos

[0]|[1]|[2]
-----------
[3]| X |[5]
-----------
[6]|[7]|[8]

eos
      expect(TicTacToe::Stringifier.stringify_board(board)).to eql(stringified_board)
    end
  end
end
