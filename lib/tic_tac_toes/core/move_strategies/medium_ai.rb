require 'tic_tac_toes/core/move_strategies/easy_ai'
require 'tic_tac_toes/core/move_strategies/hard_ai'

module TicTacToes
  module Core
    module MoveStrategies
      module MediumAI
        def self.move(board, players)
          move_strategy = [EasyAI, HardAI, HardAI].sample
          move_strategy.move(board, players)
        end
      end
    end
  end
end
