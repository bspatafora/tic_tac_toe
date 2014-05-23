require 'spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/exceptions'

describe TicTacToe::Board do
  let(:board) { TicTacToe::Board.new }


  describe '#initialize' do
    it "doesn't accept invalid row sizes" do
      invalid_row_size = -4
      expect{ TicTacToe::Board.new(row_size: invalid_row_size) }.to raise_error(TicTacToe::InvalidRowSize)
    end

    it "accepts valid row sizes" do
      valid_row_size = 4
      board_size = valid_row_size ** 2
      board = TicTacToe::Board.new(row_size: valid_row_size)
      expect(board.size).to eql(board_size)
    end
  end


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
      row_size = 4
      row_structure = Array.new(row_size) { nil }
      rows_array = Array.new(row_size) { row_structure }

      big_board = TicTacToe::Board.new(row_size: row_size)
      expect(big_board.generate_rows).to eql(rows_array)
    end
  end
end
