require 'tic_tac_toe/stringifier'

module TicTacToe
  module CommandLineIO
    def self.make_move(_board, _players)
      move_solicitation

      Integer(get_input)
      rescue ArgumentError
        red_notification(Stringifier.not_an_integer)
        make_move(_board, _players)
    end

    def self.get_row_size
      row_size_solicitation

      Integer(get_input)
      rescue ArgumentError
        red_notification(Stringifier.not_an_integer)
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
      print Stringifier.move_solicitation
    end

    def self.row_size_solicitation
      print Stringifier.row_size_solicitation
    end

    def self.token_solicitation(player)
      print Stringifier.token_solicitation(player)
    end

    def self.difficulty_solicitation
      print Stringifier.difficulty_solicitation
    end

    def self.draw_board(board)
      print Stringifier.board(board)
    end

    def self.red_notification(message)
      print red(message)
    end

    def self.game_over_notification(winner)
      winner = "Nobody" if winner.nil?
      print Stringifier.game_over_notification(winner)
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
