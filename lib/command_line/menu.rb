require 'tic_tac_toe/board'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/rules'

module CommandLine
  class Menu
    def initialize(io_interface)
      @io_interface = io_interface
      @player_factory = TicTacToe::PlayerFactory.new(io_interface)
    end

    def get_board
      TicTacToe::Board.new(row_size: get_row_size)
    end

    def get_row_size
      loop do
        row_size = @io_interface.get_row_size
        break row_size if TicTacToe::Rules.row_size_valid?(row_size)
        @io_interface.invalid_row_size_error
      end
    end

    def get_players
      taken_tokens = []
      human_token = get_token(:human, taken_tokens)
      taken_tokens << human_token

      computer_token = get_token(:computer, taken_tokens)
      difficulty = get_difficulty

      human_player = @player_factory.generate_human_player(human_token)
      computer_player = @player_factory.generate_computer_player(computer_token, difficulty)

      [human_player, computer_player]
    end

    def get_token(player, taken_tokens)
      loop do
        token = @io_interface.get_token(player)
        break token if TicTacToe::Rules.token_valid?(token, taken_tokens)
        @io_interface.invalid_token_error
      end
    end

    def get_difficulty
      loop do
        difficulty = @io_interface.get_difficulty
        break difficulty if TicTacToe::Rules.difficulty_valid?(difficulty)
        @io_interface.invalid_difficulty_error
      end
    end
  end
end
