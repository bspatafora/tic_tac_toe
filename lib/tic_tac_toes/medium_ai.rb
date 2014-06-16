require 'tic_tac_toes/easy_ai'
require 'tic_tac_toes/hard_ai'

module TicTacToes
  module MediumAI
    def self.make_move(board, players)
      ai = [EasyAI, HardAI, HardAI].sample
      ai.make_move(board, players)
    end
  end
end
