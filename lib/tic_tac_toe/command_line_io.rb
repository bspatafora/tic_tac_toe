module TicTacToe
  class CommandLineIO
    def initialize(game)
      @game = game
    end

    def send_move
      begin
        ask_for_move
        space = Integer(solicit_move)
        @game.make_move(space)
      rescue ArgumentError, InvalidMove
        say_invalid_move
        send_move
      end
    end

    def solicit_move
      gets.chomp
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
      print TicTacToe::Stringifier.stringify_board(@game.board.board)
    end
  end
end
