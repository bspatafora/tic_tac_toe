require 'tic_tac_toe/rules'
require 'tic_tac_toe/command_line_io'

module TicTacToe
  class CommandLineRunner
    def initialize(board, players)
      @board = board
      @players = players
    end

    def run
      take_turn until Rules.game_over?(@players, @board)
      end_game
    end

    def take_turn
      CommandLineIO.draw_board(@board)
      @players.first.make_move(@board, @players)
      @players.rotate!
    end

    def end_game
      CommandLineIO.draw_board(@board)
      CommandLineIO.say_game_over(Rules.determine_winner(@players, @board))
    end
  end
end
