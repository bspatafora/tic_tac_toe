require 'tic_tac_toes/easy_ai'
require 'tic_tac_toes/hard_ai'

module TicTacToes
  module MediumAI
    def self.move(board, players)
      move_strategy = [EasyAI, HardAI, HardAI].sample
      move_strategy.move(board, players)
    end
  end
end
