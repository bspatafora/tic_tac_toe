require 'tic_tac_toe/exceptions'
require 'tic_tac_toe/stringifier'

module TicTacToe
  module CommandLineIO
    def self.get_row_size
      begin
        ask_for_row_size
        Integer(get_input)
      rescue ArgumentError
        get_row_size
      end
    end

    def self.ask_for_row_size
      print Stringifier.row_size_solicitation
    end

    def self.get_token(player)
      ask_for_token(player)
      get_input.to_sym
    end

    def self.ask_for_token(player)
      print Stringifier.token_solicitation(player)
    end

    def self.get_difficulty
      ask_for_difficulty
      get_input.downcase.to_sym
    end

    def self.ask_for_difficulty
      print Stringifier.difficulty_solicitation
    end

    def self.make_move(board, players)
      begin
        ask_for_move
        Integer(get_input)
      rescue ArgumentError
        make_move(board, players)
      end
    end

    def self.ask_for_move
      print Stringifier.move_solicitation
    end

    def self.say_game_over(winner)
      winner = "Nobody" if winner.nil?
      print Stringifier.game_over_notification(winner)
    end

    def self.draw_board(board)
      print Stringifier.board(board)
    end

    private

    def self.get_input
      gets.chomp
    end
  end
end
