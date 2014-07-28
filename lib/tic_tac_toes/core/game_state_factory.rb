require 'tic_tac_toes/core/game_state'

module TicTacToes
  module Core
    class GameStateFactory
      def initialize(history)
        @history = history
      end

      def generate_game_state(board, players)
        GameState.new(board, players, @history)
      end
    end
  end
end
