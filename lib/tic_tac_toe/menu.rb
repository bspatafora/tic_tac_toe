require 'tic_tac_toe/board'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/stringifier'

module TicTacToe
  class Menu
    def initialize(io: CommandLineIO, stringifier: Stringifier)
      @io = io
      @stringifier = stringifier
    end

    def get_board
      Board.new(row_size: get_row_size)
    end

    def get_row_size
      loop do
        row_size = @io.get_row_size
        break row_size if Rules.row_size_valid?(row_size)
        @io.red_notification(@stringifier.invalid_row_size)
      end
    end

    def get_players
      taken_tokens = []
      human_token = get_token(:human, taken_tokens)
      taken_tokens << human_token

      computer_token = get_token(:computer, taken_tokens)
      difficulty = get_difficulty

      human_player = PlayerFactory.generate_human_player(human_token)
      computer_player = PlayerFactory.generate_computer_player(computer_token, difficulty)

      [human_player, computer_player]
    end

    def get_token(player, taken_tokens)
      loop do
        token = @io.get_token(player)
        break token if Rules.token_valid?(token, taken_tokens)
        @io.red_notification(@stringifier.invalid_token)
      end
    end

    def get_difficulty
      loop do
        difficulty = @io.get_difficulty
        break difficulty if Rules.difficulty_valid?(difficulty)
        @io.red_notification(@stringifier.invalid_difficulty)
      end
    end
  end
end
