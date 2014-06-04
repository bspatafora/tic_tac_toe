require 'tic_tac_toe/stringifier'

module CommandLine
  module IO
    def self.make_move(_board, _players)
      move_solicitation

      Integer(get_input)
      rescue ArgumentError
        red_notification(TicTacToe::Stringifier.not_an_integer)
        make_move(_board, _players)
    end

    def self.get_row_size
      row_size_solicitation

      Integer(get_input)
      rescue ArgumentError
        red_notification(TicTacToe::Stringifier.not_an_integer)
        get_row_size
    end

    def self.get_token(player)
      token_solicitation(player)

      get_input
    end

    def self.get_difficulty
      difficulty_solicitation

      get_input.downcase.to_sym
    end

    def self.move_solicitation
      print TicTacToe::Stringifier.move_solicitation
    end

    def self.row_size_solicitation
      print TicTacToe::Stringifier.row_size_solicitation
    end

    def self.token_solicitation(player)
      print TicTacToe::Stringifier.token_solicitation(player)
    end

    def self.difficulty_solicitation
      print TicTacToe::Stringifier.difficulty_solicitation
    end

    def self.draw_board(board)
      print TicTacToe::Stringifier.board(board)
    end

    def self.red_notification(message)
      print red(message)
    end

    def self.not_an_integer_error
      red_notification(TicTacToe::Stringifier.not_an_integer)
    end

    def self.invalid_row_size_error
      red_notification(TicTacToe::Stringifier.invalid_row_size)
    end

    def self.invalid_token_error
      red_notification(TicTacToe::Stringifier.invalid_token)
    end

    def self.invalid_difficulty_error
      red_notification(TicTacToe::Stringifier.invalid_difficulty)
    end

    def self.invalid_move_error
      red_notification(TicTacToe::Stringifier.invalid_move)
    end

    def self.thinking_notification
      red_notification(TicTacToe::Stringifier.thinking)
    end

    def self.game_over_notification(winner)
      winner = "Nobody" if winner.nil?
      print TicTacToe::Stringifier.game_over_notification(winner)
    end

    private

    def self.get_input
      gets.chomp
    end

    def self.red(message)
      colorize(message, 31)
    end

    def self.blue(message)
      colorize(message, 34)
    end

    def self.colorize(message, color_code)
      "\e[#{color_code}m#{message}\e[0m"
    end
  end
end
