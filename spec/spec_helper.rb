require 'tic_tac_toe/board'

def generate_board(structure)
  board = TicTacToe::Board.new
  structure.each_with_index do |token, index|
    board.place(index, token)
  end
  board
end
