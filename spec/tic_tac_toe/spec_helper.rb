require 'tic_tac_toe/board'

def generate_board(structure)
  board_size = structure.count
  row_size = Math.sqrt(board_size)
  board = TicTacToe::Board.new(row_size: row_size)

  structure.each_with_index do |token, index|
    board.place(token, index)
  end

  board
end
