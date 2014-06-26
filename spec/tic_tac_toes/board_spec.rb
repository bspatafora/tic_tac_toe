require 'test_board_generator'
require 'tic_tac_toes/board'

describe TicTacToes::Board do
  describe '#place (and #space)' do
    let(:board) { TicTacToes::Board.new(row_size: 3) }

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
      board = TestBoardGenerator.generate([:X, :O, nil,
                                           :O, :O,  :X,
                                           :X, :X, nil])
      open_spaces = [2, 8]

      expect(board.open_spaces).to eql(open_spaces)
    end
  end


  describe '#rows' do
    it "returns an array of row arrays based on the board's spaces" do
      board = TestBoardGenerator.generate([ :X,  :X,  :X,  :X,
                                           nil, nil, nil, nil,
                                           nil, nil, nil, nil,
                                           nil, nil, nil, nil])
      first_row = [:X, :X, :X, :X]

      expect(board.rows.size).to eq(4)
      expect(board.rows.first).to eql(first_row)
    end
  end


  describe '#columns' do
    it "returns an array of column arrays based on the board's spaces" do
      board = TestBoardGenerator.generate([:X, nil, nil, nil,
                                           :X, nil, nil, nil,
                                           :X, nil, nil, nil,
                                           :X, nil, nil, nil])
      first_column = [:X, :X, :X, :X]

      expect(board.columns.size).to eq(4)
      expect(board.columns.first).to eql(first_column)
    end
  end


  describe '#diagonals' do
    it "returns an array of diagonal arrays based on the board's spaces" do
      board = TestBoardGenerator.generate([ :X, nil, nil,  :O,
                                           nil,  :X,  :O, nil,
                                           nil,  :O,  :X, nil,
                                            :O, nil, nil,  :X])
      back_diagonal  = [:X, :X, :X, :X]
      front_diagonal = [:O, :O, :O, :O]

      expect(board.diagonals.size).to eq(2)
      expect(board.diagonals.first).to eql(back_diagonal)
      expect(board.diagonals.last).to eql(front_diagonal)
    end
  end


  describe '#full?' do
    it "returns false if any spaces are still nil" do
      board = TicTacToes::Board.new
      expect(board.full?).to be false
    end

    it "returns true if all spaces are non-nil" do
      board = TestBoardGenerator.generate([:X, :O, :X,
                                           :O, :X, :O,
                                           :X, :O, :X])

      expect(board.full?).to be true
    end
  end
end
