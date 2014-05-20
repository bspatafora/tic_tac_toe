module TicTacToe
  class Board
    attr_reader :size

    def initialize
      @size = 9
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
      row_size = Math.sqrt(@size)
      @spaces.each_slice(row_size).to_a
    end

    private

    def valid?(move)
      space_empty = @spaces[move].nil?
      board_range = 0..@size-1
      on_the_board = board_range.include? move
      space_empty && on_the_board
    end
  end
end
