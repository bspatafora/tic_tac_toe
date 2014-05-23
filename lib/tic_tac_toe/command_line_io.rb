require 'tic_tac_toe/exceptions'
require 'tic_tac_toe/stringifier'

module TicTacToe
  module CommandLineIO
    def self.get_row_size
      begin
        ask_for_row_size
        Integer(solicit_input)
      rescue ArgumentError
        get_row_size
      end
    end

    def self.ask_for_row_size
      print Stringifier.stringify_ask_for_row_size
    end

    def self.get_token(player)
      ask_for_token(player)
      solicit_input.to_sym
    end

    def self.ask_for_token(player)
      print Stringifier.stringify_ask_for_token(player)
    end

    def self.get_difficulty
      ask_for_difficulty
      solicit_input.downcase.to_sym
    end

    def self.ask_for_difficulty
      print Stringifier.stringify_ask_for_difficulty
    end

    def self.make_move(board, players)
      begin
        ask_for_move
        Integer(solicit_input)
      rescue ArgumentError
        make_move(board, players)
      end
    end

    def self.ask_for_move
      print Stringifier.stringify_ask_for_move
    end

    def self.say_game_over(winner)
      winner = "Nobody" if winner.nil?
      print Stringifier.stringify_game_over(winner)
    end

    def self.draw_board(board)
      print Stringifier.stringify_board(board)
    end

    private

    def self.solicit_input
      gets.chomp
    end
  end
end
