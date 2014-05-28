require 'tic_tac_toe/board'

module TicTacToe
  module EasyAI
    def self.make_move(board, players)
      board.open_spaces.sample
    end
  end
end
