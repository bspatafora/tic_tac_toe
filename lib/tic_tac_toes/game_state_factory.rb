require 'tic_tac_toes/game_state'
require 'tic_tac_toes/history'
require 'tic_tac_toes/rules'

module TicTacToes
  class GameStateFactory
    def initialize(history)
      @history = history
    end

    def generate_game_state(board, players)
      TicTacToes::GameState.new(board, players, @history)
    end
  end
end
