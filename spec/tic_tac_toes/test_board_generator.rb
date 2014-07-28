require 'tic_tac_toes/core/board'

module TicTacToes
  module TestBoardGenerator
    def self.generate(structure)
      board_size = structure.count
      row_size = Math.sqrt(board_size)
      board = TicTacToes::Core::Board.new(row_size: row_size)

      structure.each_with_index do |player, index|
        board.place(player, index)
      end

      board
    end
  end
end
