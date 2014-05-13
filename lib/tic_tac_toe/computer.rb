module TicTacToe
  class Computer
    def initialize(board)
      @board = board
    end

    def make_move
      @board.board.each_with_index { |space, index| return index if space.nil? }
    end
  end
end
