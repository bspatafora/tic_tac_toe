module TicTacToe
  module Stringifier
    def self.stringify_ask_for_row_size
      "Pick row size of board:\n"
    end

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
      board_size = board.size
      row_size = Math.sqrt(board_size)
      stringified_board = ""

      rows.each_with_index do |row, index|
        row_start_index = (index * row_size).to_i
        is_last_row = index == row_size - 1

        stringified_board << "\n"
        stringified_board << stringify_row(row, row_start_index, board_size)
        stringified_board << "\n"
        stringified_board << stringify_horizontal_divider(row_size, board_size) unless is_last_row
      end

      stringified_board << "\n"
    end

    private

    def self.stringify_row(row, row_start_index, board_size)
      stringified_row = []
      row.each_with_index do |space, index|
        if space.nil?
          board_index = index + row_start_index
          stringified_row << stringify_empty_space(board_index, board_size)
        else
          stringified_row << stringify_token(space, board_size)
        end
      end
      stringified_row.join("|")
    end

    def self.stringify_empty_space(board_index, board_size)
      if space_needs_buffer?(board_index, board_size)
        "[ #{board_index}]"
      else
        "[#{board_index}]"
      end
    end

    def self.space_needs_buffer?(board_index, board_size)
      is_double_digit_board = double_digit_board?(board_size)
      is_single_digit_space = board_index < 10
      is_double_digit_board && is_single_digit_space
    end

    def self.stringify_token(space, board_size)
      if double_digit_board?(board_size)
        "  #{space} "
      else
        " #{space} "
      end
    end

    def self.stringify_horizontal_divider(row_size, board_size)
      horizontal_divider = ""
      divider_unit = "-"
      divider_units_per_space = double_digit_board?(board_size) ? 5 : 4
      extra_units_per_row = 1

      raw_length = (row_size * divider_units_per_space).to_i
      truncated_length = raw_length - extra_units_per_row
      truncated_length.times { horizontal_divider << divider_unit }
      horizontal_divider
    end

    def self.double_digit_board?(board_size)
      board_size > 10
    end
  end
end
