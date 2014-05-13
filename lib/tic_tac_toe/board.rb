module TicTacToe
  class Board
    attr_reader :size, :board

    def initialize
      @size = 9
      @board = Array.new(@size)
    end

    def place(space, token)
      space_empty = @board[space].nil?
      on_the_board = (0..(@board.size - 1)).include? space
      if space_empty && on_the_board
        @board[space] = token
      else
        raise InvalidMove
      end
    end

    def read(position)
      @board[position]
    end

    def generate_row_slices
      @board.each_slice(3).to_a
    end
  end
end
