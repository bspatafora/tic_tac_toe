require 'tic_tac_toes/core/board'

module TicTacToes
  module Core
    class BoardFactory
      def generate_board(row_size)
        Board.new(row_size: row_size)
      end
    end
  end
end
