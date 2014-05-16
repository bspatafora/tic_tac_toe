require 'tic_tac_toe/Stringifier'

module TicTacToe
  module CommandLineIO
    def self.make_move(board, players)
      begin
        ask_for_move
        Integer(solicit_move)
      rescue ArgumentError
        make_move(board, players)
      end
    end

    def self.solicit_move
      gets.chomp
    end

    def self.ask_for_move
      print TicTacToe::Stringifier.stringify_ask_for_move
    end

    def self.say_game_over(winner)
      winner = "Nobody" if winner.nil?
      print TicTacToe::Stringifier.stringify_game_over(winner)
    end

    def self.draw_board(board)
      print TicTacToe::Stringifier.stringify_board(board)
    end
  end
end
