module CommandLine
  class Runner
    def initialize(io, menu, rules, history)
      @io = io
      @menu = menu
      @rules = rules
      @history = history
    end

    def run
      board, players = @menu.get_board, @menu.get_players
      @history.record_board_size(board.size)

      take_turn(board, players) until @rules.game_over?(board, players)
      end_game(board, players)
    end

    def take_turn(board, players)
      @io.draw_board(board)
      @io.thinking_notification if players.first.needs_to_think

      move = players.first.place_and_return_move(board, players)
      @history.record_move(move)
      players.rotate!
    end

    def end_game(board, players)
      @io.draw_board(board)

      winner = @rules.determine_winner(board, players)

      @history.record_winner(winner)
      @history.persist
      @io.game_over_notification(winner)
    end
  end
end
