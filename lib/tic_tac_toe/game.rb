module TicTacToe
  class Game
    def initialize
      @board = Array.new(9)
    end

    def place(move)
      raise InvalidMove
    end
  end
end
