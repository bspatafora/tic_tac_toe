require 'spec_helper'

describe TicTacToe::Computer do
  describe '#make_move' do
    it "returns a valid move" do
      board = TicTacToe::Board.new
      computer = TicTacToe::Computer.new(board)
      board.place(0, :X)
      expect(computer.make_move).to eql(1)
    end
  end
end
