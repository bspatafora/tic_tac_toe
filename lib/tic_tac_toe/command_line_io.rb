require 'tic_tac_toe/Stringifier'

module TicTacToe
  module CommandLineIO
    def self.make_move(board, players)
      begin
        ask_for_move
        Integer(solicit_input)
      rescue ArgumentError
        make_move(board, players)
      end
    end

    def self.ask_for_move
      print TicTacToe::Stringifier.stringify_ask_for_move
    end

    def self.get_token(player)
      ask_for_token(player)
      solicit_input.to_sym
    end

    def self.ask_for_token(player)
      print TicTacToe::Stringifier.stringify_ask_for_token(player)
    end

    def self.get_difficulty
      ask_for_difficulty
      case solicit_input.downcase
      when "easy"
        :easy
      when "medium"
        :medium
      when "hard"
        :hard
      else
        get_difficulty
      end
    end

    def self.ask_for_difficulty
      print TicTacToe::Stringifier.stringify_ask_for_difficulty
    end

    def self.say_game_over(winner)
      winner = "Nobody" if winner.nil?
      print TicTacToe::Stringifier.stringify_game_over(winner)
    end

    def self.draw_board(board)
      print TicTacToe::Stringifier.stringify_board(board)
    end

    private

    def self.solicit_input
      gets.chomp
    end
  end
end
