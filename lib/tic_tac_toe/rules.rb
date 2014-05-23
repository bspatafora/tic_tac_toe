module TicTacToe
  module Rules
    def self.row_size_valid?(row_size)
      row_size.between?(2, 10)
    end

    def self.token_valid?(token, taken_tokens)
      correct_length = token.length == 1
      untaken = !taken_tokens.include?(token)
      correct_length && untaken
    end

    def self.game_over?(players, board)
      winner = !!determine_winner(players, board)
      tie = board.get_spaces.all? { |space| space != nil }
      winner || tie
    end

    def self.determine_winner(players, board)
      winner = nil
      players.each do |player|
        player_has_won = win?(player.token, board)
        winner = player.token if player_has_won
      end
      winner
    end

    def self.win?(token, board)
      diagonal_win?(token, board) || horizontal_win?(token, board) || vertical_win?(token, board)
    end

    private

    def self.diagonal_win?(token, board)
      row_size = Math.sqrt(board.size)
      back_diagonal, front_diagonal = true, true
      board.generate_rows.each_with_index do |row, index|
        back_diagonal = false if row[index] != token
        front_diagonal = false if row[row_size - (index + 1)] != token
      end
      back_diagonal || front_diagonal
    end

    def self.horizontal_win?(token, board)
      row_win?(board.generate_rows, token)
    end

    def self.vertical_win?(token, board)
      transposed_rows = board.generate_rows.transpose
      row_win?(transposed_rows, token)
    end

    def self.row_win?(rows, token)
      rows.any? { |row| row.all? { |space| space == token  } }
    end
  end
end
