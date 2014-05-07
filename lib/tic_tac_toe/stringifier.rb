module TicTacToe
  module Stringifier
    def self.stringify_ask_for_move
      "Pick a space."
    end

    def self.stringify_invalid_move
      "Invalid move."
    end

    def self.stringify_game_over(winner)
      "#{winner} wins!"
    end

    def self.stringify_board(board)
      row_size = Math.sqrt(board.size)
      rows = board.each_slice(row_size).to_a
      stringified_board = String.new
      rows.each_with_index do |row, index|
        stringified_board << "\n"
        stringified_board << stringify_row(row)
        stringified_board << "\n"
        stringified_board << "-----------" unless index == row_size - 1
      end
      stringified_board
    end

    def self.stringify_row(row)
      row.map { |space| space.nil? ? "   " : " #{space} " }.join("|")
    end
  end
end
