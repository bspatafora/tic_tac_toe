require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'

describe TicTacToe::Board do
  describe '#place (and #space)' do
    let(:board) { TicTacToe::Board.new(row_size: 3) }

    it "returns nil if the space is not nil" do
      first_token, second_token = :X, :O
      space = 0

      board.place(first_token, space)
      expect(board.place(second_token, space)).to be_nil
    end

    it "returns nil if it isn't in the board's spaces range" do
      expect(board.place(:X, 9)).to be_nil
    end

    it "places a token at a space if the space is nil and in the board's spaces range" do
      token, valid_space = :X, 0

      board.place(token, valid_space)
      expect(board.space(valid_space)).to eql(token)
    end
  end


  describe '#open_spaces' do
    it "returns an array of the board's nil spaces" do
      structure = [:X, :O, nil,
                   :O, :O,  :X,
                   :X, :X, nil]
      board = generate_board(structure)
      open_spaces = [2, 8]

      expect(board.open_spaces).to eql(open_spaces)
    end
  end


  describe '#rows' do
    it "returns an array of row arrays based on the board's spaces" do
      structure = [ :X,  :X,  :X,  :X,
                   nil, nil, nil, nil,
                   nil, nil, nil, nil,
                   nil, nil, nil, nil]
      board = generate_board(structure)
      first_row = [:X, :X, :X, :X]

      expect(board.rows).to have(4).rows
      expect(board.rows.first).to eql(first_row)
    end
  end


  describe '#full?' do
    it "returns false if any spaces are still nil" do
      board = TicTacToe::Board.new
      expect(board.full?).to be false
    end

    it "returns true if all spaces are non-nil" do
      structure = [:X, :O, :X,
                   :O, :X, :O,
                   :X, :O, :X]
      board = generate_board(structure)

      expect(board.full?).to be true
    end
  end
end
