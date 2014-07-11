require 'tic_tac_toes/rules'

module CommandLine
  class Menu
    def initialize(io, board_factory, player_factory)
      @io = io
      @board_factory = board_factory
      @player_factory = player_factory
    end

    def get_board
      @board_factory.generate_board(get_row_size)
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

    private

    def get_row_size
      loop do
        row_size = @io.get_row_size
        break row_size if TicTacToes::Rules.row_size_valid?(row_size)
        @io.invalid_row_size_error
      end
    end

    def get_token(player, taken_tokens)
      loop do
        token = @io.get_token(player)
        break token if TicTacToes::Rules.token_valid?(token, taken_tokens)
        @io.invalid_token_error
      end
    end

    def get_difficulty
      loop do
        difficulty = @io.get_difficulty
        break difficulty if TicTacToes::Rules.difficulty_valid?(difficulty)
        @io.invalid_difficulty_error
      end
    end
  end
end
