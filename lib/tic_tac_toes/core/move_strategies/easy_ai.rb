require 'tic_tac_toes/core/board'

module TicTacToes
  module Core
    module MoveStrategies
      module EasyAI
        def self.move(board, players)
          board.open_spaces.sample
        end
      end
    end
  end
end
