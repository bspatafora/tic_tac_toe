require 'tic_tac_toe/rules'

module TicTacToe
  module Stringifier
    def self.not_an_integer
      "Input must be an integer\n"
    end

    def self.invalid_row_size
      "Input must be between #{Rules::ROW_SIZE_RANGE.min} and #{Rules::ROW_SIZE_RANGE.max}\n"
    end

    def self.invalid_token
      "Input must be a single, untaken character\n"
    end

    def self.invalid_difficulty
      "Input must be a valid difficulty\n"
    end

    def self.invalid_move
      "Input must be a space that is on the board and untaken\n"
    end

    def self.thinking
      "Thinking...\n"
    end

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
      board_string = ""

      board.rows.each_with_index do |row, index|
        row_start_index = (index * board.row_size).to_i
        at_last_row = index == board.row_size - 1

        board_string << "\n"
        board_string << row(row, row_start_index, board.size)
        board_string << "\n"
        board_string << horizontal_divider(board.row_size, board.size) unless at_last_row
      end

      board_string << "\n"
    end

    private

    def self.row(row, row_start_index, board_size)
      row_array = []

      row.each_with_index do |space, index|
        if space.nil?
          board_index = index + row_start_index
          row_array << empty_space(board_index, board_size)
        else
          row_array << token(space, board_size)
        end
      end

      row_array.join("|")
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
