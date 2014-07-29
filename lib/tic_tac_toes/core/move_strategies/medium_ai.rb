require 'tic_tac_toes/core/move_strategies/easy_ai'
require 'tic_tac_toes/core/move_strategies/hard_ai'

module TicTacToes
  module Core
    module MoveStrategies
      module MediumAI
        def self.move(game_state)
          move_strategy = [EasyAI, HardAI, HardAI].sample
          move_strategy.move(game_state)
        end
      end
    end
  end
end
