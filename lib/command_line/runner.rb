module CommandLine
  class Runner
    def initialize(io_interface, menu, rules)
      @io_interface = io_interface
      @menu = menu
      @rules = rules
    end

    def run
      board, players = @menu.get_board, @menu.get_players

      take_turn(board, players) until @rules.game_over?(board, players)
      end_game(board, players)
    end

    def take_turn(board, players)
      @io_interface.draw_board(board)
      @io_interface.thinking_notification if players.first.needs_to_think
      players.first.make_move(board, players)
      players.rotate!
    end

    def end_game(board, players)
      @io_interface.draw_board(board)
      @io_interface.game_over_notification(@rules.determine_winner(board, players))
    end
  end
end
