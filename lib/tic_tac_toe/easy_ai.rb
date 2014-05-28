require 'tic_tac_toe/board'

module TicTacToe
  module EasyAI
    def self.make_move(board, _players)
      board.open_spaces.sample
    end
  end
end
