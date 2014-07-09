module TicTacToes
  class GameState
    def initialize(board, players, history)
      @board = board
      @players = players
      @history = history
    end

    def current_player
      @players.first
    end

    def turn_over(move)
      @history.record_move(move)
      @players.rotate!
    end

    def game_over(winner)
      @history.record_winner(winner)
    end
  end
end
