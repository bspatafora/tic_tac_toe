require 'tic_tac_toes/board'

module TicTacToes
  module EasyAI
    def self.make_move(board, _players)
      board.open_spaces.sample
    end
  end
end
