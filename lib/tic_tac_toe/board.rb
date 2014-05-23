module TicTacToe
  class Board
    attr_reader :row_size, :size

    def initialize(row_size: 3)
      @row_size = validate_size(row_size)
      @size = @row_size ** 2
      @spaces = Array.new(@size)
    end

    def place(move, token)
      if valid?(move)
        @spaces[move] = token
      else
        raise InvalidMove
      end
    end

    def get_space(space)
      @spaces[space]
    end

    def get_spaces
      @spaces
    end

    def get_open_spaces
      open_spaces = Array.new
      @spaces.each_with_index do |space, index|
        open_spaces << index if space.nil?
      end
      open_spaces
    end

    def generate_rows
      @spaces.each_slice(@row_size).to_a
    end

    private

    def validate_size(row_size)
      if Rules.row_size_valid?(row_size)
        row_size
      else
        raise InvalidRowSize
      end
    end

    def valid?(move)
      space_empty = @spaces[move].nil?
      board_range = 0..@size-1
      on_the_board = board_range.include? move
      space_empty && on_the_board
    end
  end
end
