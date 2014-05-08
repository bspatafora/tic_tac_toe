module TicTacToe
  class Game
    attr_reader :board

    def initialize
      @board = Array.new(9)
      @row_size = Math.sqrt(@board.size)
      @tokens = [:X, :O]
    end

    def place(move)
      if @board[move].nil? && move < @board.size
        @board[move] = @tokens.first
        @tokens.rotate!
      else
        raise InvalidMove
      end
    end

    def over?
      determine_winner != false || @board.all? { |space| space != nil }
    end

    def determine_winner
      if win?(:X)
        :X
      elsif win?(:O)
        :O
      else
        false
      end
    end

    def win?(token)
      diagonal_win?(token) || horizontal_win?(token) || vertical_win?(token)
    end

    private

    def diagonal_win?(token)
      back_diagonal, front_diagonal = true, true
      generate_row_slices.each_with_index do |row, index|
        back_diagonal = false if row[index] != token
        front_diagonal = false if row[@row_size - (index + 1)] != token
      end
      back_diagonal || front_diagonal
    end

    def horizontal_win?(token)
      linear_win?(generate_row_slices, token)
    end

    def vertical_win?(token)
      transposed_rows = generate_row_slices.transpose
      linear_win?(transposed_rows, token)
    end

    def generate_row_slices
      @board.each_slice(@row_size).to_a
    end

    def linear_win?(rows, token)
      rows.any? { |row| row.all? { |space| space == token  } }
    end
  end
end
