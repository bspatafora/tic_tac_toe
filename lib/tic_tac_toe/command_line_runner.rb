require 'tic_tac_toe/hard_ai'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/exceptions'
require 'tic_tac_toe/player'
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
      human = generate_player(:human, CommandLineIO, taken_tokens)
      taken_tokens << human.token
      computer = generate_player(:computer, HardAI, taken_tokens)
      [human, computer]
    end

    def generate_player(player_type, decider, taken_tokens)
      begin
        token = CommandLineIO.get_token(player_type)
        Player.new(decider, token, taken_tokens)
      rescue InvalidToken
        generate_player(player_type, decider, taken_tokens)
      end
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
