module TicTacToe
  class CommandLineIO
    def initialize(game)
      @game = game
    end

    def solicit_move
      print TicTacToe::Stringifier.stringify_solicit_move
    end

    def say_invalid_move
      print TicTacToe::Stringifier.stringify_invalid_move
    end

    def draw_board
      print TicTacToe::Stringifier.stringify_board(@game.board)
    end
  end
end
