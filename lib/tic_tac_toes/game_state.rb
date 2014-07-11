module TicTacToes
  class GameState
    attr_reader :board, :players

    def initialize(board, players, history)
      @board = board
      @players = players
      @history = history

      @history.record_board_size(@board.size)
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
      @history.persist
    end
  end
end
