require 'tic_tac_toe/exceptions'
require 'tic_tac_toe/rules'

module TicTacToe
  class Board
    attr_reader :row_size, :size

    def initialize(row_size: 3)
      @row_size = validate_size(row_size)
      @size = @row_size**2
      @spaces = Array.new(@size)
    end

    def place(token, space)
      if valid?(space)
        @spaces[space] = token
      else
        fail InvalidMove
      end
    end

    def space(space)
      @spaces[space]
    end

    def open_spaces
      open_spaces = []

      @spaces.each_with_index do |space, index|
        open_spaces << index if space.nil?
      end

      open_spaces
    end

    def rows
      @spaces.each_slice(@row_size).to_a
    end

    def full?
      @spaces.all? { |space| !space.nil? }
    end

    private

    def validate_size(row_size)
      if Rules.row_size_valid?(row_size)
        row_size
      else
        fail InvalidRowSize
      end
    end

    def valid?(space)
      space_empty = @spaces[space].nil?
      board_range = 0..(@size - 1)
      on_the_board = board_range.include? space

      space_empty && on_the_board
    end
  end
end
