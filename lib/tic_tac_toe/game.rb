module TicTacToe
  class Game
    attr_reader :board, :tokens

    def initialize(board)
      @board = board
      @row_size = Math.sqrt(@board.size)
      @tokens = [:X, :O]
    end

    def make_move(space)
      @board.place(space, @tokens.first)
      @tokens.rotate!
    end

    def over?
      tie = @board.board.all? { |space| space != nil }
      determine_winner || tie
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
      @board.generate_row_slices.each_with_index do |row, index|
        back_diagonal = false if row[index] != token
        front_diagonal = false if row[@row_size - (index + 1)] != token
      end
      back_diagonal || front_diagonal
    end

    def horizontal_win?(token)
      linear_win?(@board.generate_row_slices, token)
    end

    def vertical_win?(token)
      transposed_rows = @board.generate_row_slices.transpose
      linear_win?(transposed_rows, token)
    end

    def linear_win?(rows, token)
      rows.any? { |row| row.all? { |space| space == token  } }
    end
  end
end
