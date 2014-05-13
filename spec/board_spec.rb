require 'spec_helper'

describe TicTacToe::Board do
  let(:board) { TicTacToe::Board.new }

  describe '#place and #read' do
    it "places a valid move" do
      board.place(0, :X)
      expect(board.read(0)).to eql(:X)
    end

    it "doesn't place a move if the space is occupied" do
      board.place(0, :X)
      expect{ board.place(0, :O) }.to raise_error(TicTacToe::InvalidMove)
    end

    it "doesn't place a move if it's off the board" do
      expect{ board.place(9, :X) }.to raise_error(TicTacToe::InvalidMove)
    end
  end

  describe '#generate_rows' do
    it "returns an array of row arrays" do
      row_structure = [nil, nil, nil]
      expect(board.generate_rows).to eql(Array.new(3) { row_structure })
    end
  end
end
