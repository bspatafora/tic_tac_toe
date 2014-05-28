module TicTacToe
  module Stringifier
    def self.row_size_solicitation
      "Pick row size of board:\n"
    end

    def self.token_solicitation(player)
      "Pick #{player} token:\n"
    end

    def self.difficulty_solicitation
      "Pick difficulty (easy, medium, hard):\n"
    end

    def self.move_solicitation
      "Pick a space:\n"
    end

    def self.game_over_notification(winner)
      "#{winner} wins!\n"
    end

    def self.board(board)
      stringified_board = ""

      board.rows.each_with_index do |row, index|
        row_start_index = (index * board.row_size).to_i
        is_last_row = index == board.row_size - 1

        stringified_board << "\n"
        stringified_board << row(row, row_start_index, board.size)
        stringified_board << "\n"
        stringified_board << horizontal_divider(board.row_size, board.size) unless is_last_row
      end

      stringified_board << "\n"
    end

    private

    def self.row(row, row_start_index, board_size)
      stringified_row = []

      row.each_with_index do |space, index|
        if space.nil?
          board_index = index + row_start_index
          stringified_row << empty_space(board_index, board_size)
        else
          stringified_row << token(space, board_size)
        end
      end

      stringified_row.join("|")
    end

    def self.empty_space(board_index, board_size)
      if space_needs_buffer?(board_index, board_size)
        "[ #{board_index}]"
      else
        "[#{board_index}]"
      end
    end

    def self.token(space, board_size)
      if double_digit_board?(board_size)
        "  #{space} "
      else
        " #{space} "
      end
    end

    def self.space_needs_buffer?(board_index, board_size)
      is_double_digit_board = double_digit_board?(board_size)
      is_single_digit_space = board_index < 10
      is_double_digit_board && is_single_digit_space
    end

    def self.double_digit_board?(board_size)
      board_size > 10
    end

    def self.horizontal_divider(row_size, board_size)
      horizontal_divider = ""
      divider_unit = "-"
      divider_units_per_space = double_digit_board?(board_size) ? 5 : 4
      extra_units_per_row = 1

      raw_length = (row_size * divider_units_per_space).to_i
      truncated_length = raw_length - extra_units_per_row
      truncated_length.times { horizontal_divider << divider_unit }
      horizontal_divider
    end
  end
end
