require 'tic_tac_toes/command_line/prompt'
require 'tic_tac_toes/core/rules'

module TicTacToes
  module Core
    module Strings
      smallest_row_size = Rules::ROW_SIZE_RANGE.min
      largest_row_size = Rules::ROW_SIZE_RANGE.max

      NOT_AN_INTEGER           =  "Input must be an integer"
      INVALID_ROW_SIZE         =  "Input must be between #{smallest_row_size} and #{largest_row_size}"
      INVALID_TOKEN            =  "Input must be a single, untaken character"
      INVALID_DIFFICULTY       =  "Input must be a valid difficulty"
      INVALID_MOVE             =  "Input must be a space that is on the board and untaken"
      ROW_SIZE_SOLICITATION    =  "Pick row size of board:"
      DIFFICULTY_SOLICITATION  =  "Pick difficulty (easy, medium, hard):"
      MOVE_SOLICITATION        =  "Pick a space:"
      THINKING                 =  "Thinking..."

      def self.token_solicitation(player)
        "Pick #{player} token:"
      end

      def self.game_over_notification(winner)
        "#{winner} wins!"
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
        token = get_colored_token(space)

        if double_digit_board?(board_size)
          "  #{token} "
        else
          " #{token} "
        end
      end

      def self.get_colored_token(player)
        if player.needs_to_think
          return CommandLine::Prompt.red(player.token)
        else
          return CommandLine::Prompt.blue(player.token)
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
end
