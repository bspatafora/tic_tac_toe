require 'tic_tac_toes/board_factory'

describe TicTacToes::BoardFactory do
  describe '#generate_board' do
    it 'returns a board object generated from a row size' do
      board_factory = TicTacToes::BoardFactory.new
      row_size = 5

      board = board_factory.generate_board(row_size)
      expect(board.row_size).to eq(row_size)
    end
  end
end
