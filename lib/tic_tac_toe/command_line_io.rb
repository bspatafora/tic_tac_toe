module TicTacToe
  class CommandLineIO
    def initialize(game)
      @game = game
    end

    def send_move
      begin
        ask_for_move
        @game.place(solicit_input)
      rescue InvalidMove
        say_invalid_move
        send_move
      end
    end

    def solicit_input
      gets.chomp.to_i
    end

    def ask_for_move
      print TicTacToe::Stringifier.stringify_ask_for_move
    end

    def say_invalid_move
      print TicTacToe::Stringifier.stringify_invalid_move
    end

    def say_game_over(winner)
      print TicTacToe::Stringifier.stringify_game_over(winner)
    end

    def draw_board
      print TicTacToe::Stringifier.stringify_board(@game.board)
    end
  end
end
