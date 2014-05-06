require 'spec_helper'

describe TicTacToe::Messages do
  describe '#stringify_board' do
    it "returns a stringified board" do
      board = TicTacToe::Game.new.board
      stringified_board = <<eos

___|___|___
___|___|___
   |   |   
eos
      expect(TicTacToe::Messages.stringify_board(board)).to eql(stringified_board)
    end
  end
end
