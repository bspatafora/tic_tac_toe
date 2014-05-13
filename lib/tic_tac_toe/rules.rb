module TicTacToe
  module Rules
    def self.game_over?(tokens, board)
      draw = board.board.all? { |space| space != nil }
      determine_winner(tokens, board) || draw
    end

    def self.determine_winner(tokens, board)
      winner = nil
      tokens.each { |token| winner = token if win?(token, board) }
      winner
    end

    def self.win?(token, board)
      diagonal_win?(token, board) || horizontal_win?(token, board) || vertical_win?(token, board)
    end

    private

    def self.diagonal_win?(token, board)
      row_size = Math.sqrt(board.size)
      back_diagonal, front_diagonal = true, true
      board.generate_row_slices.each_with_index do |row, index|
        back_diagonal = false if row[index] != token
        front_diagonal = false if row[row_size - (index + 1)] != token
      end
      back_diagonal || front_diagonal
    end

    def self.horizontal_win?(token, board)
      linear_win?(board.generate_row_slices, token)
    end

    def self.vertical_win?(token, board)
      transposed_rows = board.generate_row_slices.transpose
      linear_win?(transposed_rows, token)
    end

    def self.linear_win?(rows, token)
      rows.any? { |row| row.all? { |space| space == token  } }
    end
  end
end
