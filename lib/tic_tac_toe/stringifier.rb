module TicTacToe
  module Stringifier
    def self.stringify_ask_for_token(player)
      "Pick #{player} token:\n"
    end

    def self.stringify_ask_for_difficulty
      "Pick difficulty (easy, medium, hard):\n"
    end

    def self.stringify_ask_for_move
      "Pick a space:\n"
    end

    def self.stringify_game_over(winner)
      "#{winner} wins!\n"
    end

    def self.stringify_board(board)
      rows = board.generate_rows
      row_size = Math.sqrt(board.size)
      stringified_board = String.new

      rows.each_with_index do |row, index|
        row_start_index = (index * row_size).to_i
        stringified_board << "\n"
        stringified_board << stringify_row(row, row_start_index)
        stringified_board << "\n"
        stringified_board << "-----------" unless index == row_size - 1
      end

      stringified_board << "\n"
    end

    private

    def self.stringify_row(row, row_start_index)
      stringified_row = []
      row.each_with_index do |space, index|
        if space.nil?
          board_index = index + row_start_index
          stringified_row << "[#{board_index}]"
        else
          stringified_row << " #{space} "
        end
      end
      stringified_row.join("|")
    end
  end
end
