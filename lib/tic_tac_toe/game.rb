module TicTacToe
  class Game
    attr_reader :board, :tokens

    def initialize(board)
      @board = board
      @tokens = [:X, :O]
    end

    def make_move(space)
      @board.place(space, @tokens.first)
      @tokens.rotate!
    end
  end
end
