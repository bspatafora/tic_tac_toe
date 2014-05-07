module TicTacToe
  class Game
    attr_reader :board

    def initialize
      @board = Array.new(9)
      @tokens = [:X, :O]
    end

    def place(move)
      if @board[move].nil? && move < @board.size
        @board[move] = @tokens.first
        @tokens.reverse!
      else
        raise InvalidMove
      end
    end
  end
end
