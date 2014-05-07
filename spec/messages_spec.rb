require 'spec_helper'

describe TicTacToe::Messages do
  describe '#stringify_board' do
    it "returns a stringified board" do
      game = TicTacToe::Game.new
      game.place(4)
      stringified_board = <<eos

   |   |   
-----------
   | X |   
-----------
   |   |   
eos
      expect(TicTacToe::Messages.stringify_board(game.board)).to eql(stringified_board)
    end
  end
end
