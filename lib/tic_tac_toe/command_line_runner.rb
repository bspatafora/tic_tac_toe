require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/rules'

module TicTacToe
  class CommandLineRunner
    def initialize(board)
      @board = board
      @players = []
    end

    def run
      @players = generate_players
      take_turn until Rules.game_over?(@players, @board)
      end_game
    end

    def generate_players
      taken_tokens = []
      human = PlayerFactory.generate_player(:human, CommandLineIO, taken_tokens)
      taken_tokens << human.token
      difficulty = CommandLineIO.get_difficulty
      computer = PlayerFactory.generate_computer(difficulty, taken_tokens)
      [human, computer]
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
