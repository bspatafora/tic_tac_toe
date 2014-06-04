module CommandLine
  class Runner
    def initialize(io_interface, menu, rules, history)
      @io_interface = io_interface
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
      @io_interface.draw_board(board)
      @io_interface.thinking_notification if players.first.needs_to_think

      move = players.first.make_move(board, players)
      @history.record_move(move)
      players.rotate!
    end

    def end_game(board, players)
      @io_interface.draw_board(board)

      winner = @rules.determine_winner(board, players)

      @history.record_winner(winner)
      @io_interface.game_over_notification(winner)
    end
  end
end
