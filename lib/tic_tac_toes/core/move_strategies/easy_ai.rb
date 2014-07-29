module TicTacToes
  module Core
    module MoveStrategies
      module EasyAI
        def self.move(game_state)
          game_state.board.open_spaces.sample
        end
      end
    end
  end
end
