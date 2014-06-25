require 'tic_tac_toes/board'

module TicTacToes
  module EasyAI
    def self.move(board, players)
      board.open_spaces.sample
    end
  end
end
