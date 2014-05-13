module TicTacToe
  class Board
    attr_reader :size, :spaces

    def initialize
      @size = 9
      @spaces = Array.new(@size)
    end

    def place(space, token)
      space_empty = @spaces[space].nil?
      on_the_board = (0..(size - 1)).include? space
      if space_empty && on_the_board
        @spaces[space] = token
      else
        raise InvalidMove
      end
    end

    def read(position)
      @spaces[position]
    end

    def generate_rows
      @spaces.each_slice(3).to_a
    end
  end
end
