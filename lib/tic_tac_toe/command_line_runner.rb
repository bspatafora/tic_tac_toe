module TicTacToe
  class CommandLineRunner
    def initialize(io, game)
      @io = io
      @game = game
    end

    def play
      @io.say_game_over
    end
  end
end
