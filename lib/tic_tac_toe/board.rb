module TicTacToe
  class Board
    attr_reader :size

    def initialize
      @size = 9
      @spaces = Array.new(@size)
    end

    def place(space, token)
      if valid?(space)
        @spaces[space] = token
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
      @spaces.each_slice(3).to_a
    end

    private

    def valid?(space)
      space_empty = @spaces[space].nil?
      on_the_board = (0..(size - 1)).include? space
      space_empty && on_the_board
    end
  end
end
