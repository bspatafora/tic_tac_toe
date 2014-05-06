module TicTacToe
  module Messages
    def self.stringify_board(board)
      stringified_board = String.new
      row_starts = [3, 6]
      regular_spaces = [0, 1, 3, 4]
      right_spaces = [2, 5]
      bottom_spaces = [6, 7]
      bottom_right_space = [8]
      stringified_board << "\n"
      board.each_with_index do |space, index|
        stringified_board << "\n" if row_starts.include? index
        if regular_spaces.include? index
          stringified_board << stringify_regular_space(space)
        elsif right_spaces.include? index
          stringified_board << stringify_right_space(space)
        elsif bottom_spaces.include? index
          stringified_board << stringify_bottom_space(space)
        elsif bottom_right_space.include? index
          stringified_board << stringify_bottom_right_space(space)
        end
      end
      stringified_board << "\n"
      stringified_board
    end

    def self.stringify_regular_space(space)
      space.nil? ? "___|" : "_#{space}_|"
    end

    def self.stringify_right_space(space)
      space.nil? ? "___" : "_#{space}_"
    end

    def self.stringify_bottom_space(space)
      space.nil? ? "   |" : " #{space} |"
    end

    def self.stringify_bottom_right_space(space)
      space.nil? ? "   " : " #{space} "
    end
  end
end
