require 'tic_tac_toes/board'

module TicTacToes
  class BoardFactory
    def generate_board(row_size)
      TicTacToes::Board.new(row_size: row_size)
    end
  end
end
