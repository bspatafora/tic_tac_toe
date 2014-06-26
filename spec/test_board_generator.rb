require 'tic_tac_toes/board'

module TestBoardGenerator
  def self.generate(structure)
    board_size = structure.count
    row_size = Math.sqrt(board_size)
    board = TicTacToes::Board.new(row_size: row_size)

    structure.each_with_index do |player, index|
      board.place(player, index)
    end

    board
  end
end
