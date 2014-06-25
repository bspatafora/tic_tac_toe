require 'tic_tac_toes/strings'

module TicTacToes
  class IOInterface
    def initialize(io)
      @io = io
    end

    def move(board, players)
      move_solicitation

      Integer(@io.solicit_input)
      rescue ArgumentError
        not_an_integer_error
        move(board, players)
    end

    def get_row_size
      row_size_solicitation

      Integer(@io.solicit_input)
      rescue ArgumentError
        not_an_integer_error
        get_row_size
    end

    def get_token(player)
      token_solicitation(player)
      @io.solicit_input
    end

    def get_difficulty
      difficulty_solicitation
      @io.solicit_input.downcase.to_sym
    end

    def draw_board(board)
      @io.display(Strings.board(board))
    end

    def invalid_row_size_error
      @io.display_red(Strings::INVALID_ROW_SIZE)
    end

    def invalid_token_error
      @io.display_red(Strings::INVALID_TOKEN)
    end

    def invalid_difficulty_error
      @io.display_red(Strings::INVALID_DIFFICULTY)
    end

    def invalid_move_error
      @io.display_red(Strings::INVALID_MOVE)
    end

    def thinking_notification
      @io.display_red(Strings::THINKING)
    end

    def game_over_notification(winner)
      winner = "Nobody" if winner.nil?
      @io.display(Strings.game_over_notification(winner))
    end

    def red(message)
      @io.red(message)
    end

    def blue(message)
      @io.blue(message)
    end

    private

    def move_solicitation
      @io.display(Strings::MOVE_SOLICITATION)
    end

    def row_size_solicitation
      @io.display(Strings::ROW_SIZE_SOLICITATION)
    end

    def token_solicitation(player)
      @io.display(Strings.token_solicitation(player))
    end

    def difficulty_solicitation
      @io.display(Strings::DIFFICULTY_SOLICITATION)
    end

    def not_an_integer_error
      @io.display_red(Strings::NOT_AN_INTEGER)
    end
  end
end
