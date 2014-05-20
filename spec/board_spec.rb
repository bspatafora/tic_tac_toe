require 'spec_helper'
require 'tic_tac_toe/board'

describe TicTacToe::Board do
  let(:board) { TicTacToe::Board.new }


  describe '#place and #get_space' do
    it "places a valid move and allows it to be accessed" do
      board.place(0, :X)
      expect(board.get_space(0)).to eql(:X)
    end

    it "doesn't place a move if the space is occupied" do
      board.place(0, :X)
      expect{ board.place(0, :O) }.to raise_error(TicTacToe::InvalidMove)
    end

    it "doesn't place a move if it's off the board" do
      expect{ board.place(9, :X) }.to raise_error(TicTacToe::InvalidMove)
    end
  end


  describe '#get_open_spaces' do
    it "returns an array of the board's open spaces" do
      structure = [:X, :O, nil,
                   :O, :O, :X,
                   :X, :X, nil]
      board = generate_board(structure)
      open_spaces = [2, 8]
      expect(board.get_open_spaces).to eql(open_spaces)
    end
  end


  describe '#generate_rows' do
    it "returns an array of row arrays" do
      row_structure = [nil, nil, nil]
      rows_array = Array.new(3) { row_structure }
      expect(board.generate_rows).to eql(rows_array)
    end
  end
end
