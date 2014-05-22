require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/menu'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/rules'

module TicTacToe
  class CommandLineRunner
    def initialize(io: CommandLineIO, menu: Menu.new, rules: Rules)
      @io = io
      @menu = menu
      @rules = rules
    end

    def run
      game_state = @menu.get_initial_game_state
      board = game_state[:board]
      players = game_state[:players]
      take_turn(board, players) until @rules.game_over?(players, board)
      end_game(board, players)
    end

    def take_turn(board, players)
      @io.draw_board(board)
      players.first.make_move(board, players)
      players.rotate!
    end

    def end_game(board, players)
      @io.draw_board(board)
      @io.say_game_over(@rules.determine_winner(players, board))
    end
  end
end
