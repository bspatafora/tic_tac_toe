require 'tic_tac_toes/core/move_strategies/types'

module TicTacToes
  module Core
    module MoveStrategies
      module EasyAI
        def self.to_s
          'Easy AI'
        end

        def self.type
          MoveStrategies::COMPUTER
        end

        def self.ai_type
          'EASY_AI'
        end

        def self.move(game_state)
          game_state.board.open_spaces.sample
        end
      end
    end
  end
end
