require 'tic_tac_toes/core/board_factory'

describe TicTacToes::Core::BoardFactory do
  describe '#generate_board' do
    it 'returns a board object generated from a row size' do
      board_factory = TicTacToes::Core::BoardFactory.new
      row_size = 5

      board = board_factory.generate_board(row_size)
      expect(board.row_size).to eq(row_size)
    end
  end
end
