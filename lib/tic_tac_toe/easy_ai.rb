require 'tic_tac_toe/board'

module TicTacToe
  module EasyAI
    def self.make_move(board, players)
      open_spaces = board.get_open_spaces
      open_spaces.sample
    end
  end
end
