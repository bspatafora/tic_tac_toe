require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/menu'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/stringifier'

module TicTacToe
  class CommandLineRunner
    def initialize(io: CommandLineIO, menu: Menu.new, rules: Rules)
      @io = io
      @menu = menu
      @rules = rules
    end

    def run
      board, players = @menu.get_board, @menu.get_players

      take_turn(board, players) until @rules.game_over?(board, players)
      end_game(board, players)
    end

    def take_turn(board, players)
      @io.draw_board(board)
      @io.red_notification(Stringifier.thinking) if players.first.needs_to_think
      players.first.make_move(board, players)
      players.rotate!
    end

    def end_game(board, players)
      @io.draw_board(board)
      @io.game_over_notification(@rules.determine_winner(board, players))
    end
  end
end
