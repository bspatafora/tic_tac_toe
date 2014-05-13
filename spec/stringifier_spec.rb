require 'spec_helper'

describe TicTacToe::Stringifier do
  describe '#stringify_board' do
    it "returns a stringified board" do
      board = TicTacToe::Board.new
      board.place(4, :X)
      stringified_board = <<eos

   |   |   
-----------
   | X |   
-----------
   |   |   

eos
      expect(TicTacToe::Stringifier.stringify_board(board)).to eql(stringified_board)
    end
  end
end
