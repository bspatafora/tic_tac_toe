module TicTacToe
  module Messages
    def self.stringify_board(board)
      row_size = 3
      stringified_board = String.new
      board.each_with_index do |space, index|
        stringified_board << "\n" if index % row_size == 0
        if (index + 1) % row_size == 0 && ((board.size - row_size)..(board.size - 1)).include?(index)
          stringified_board << stringify_bottom_right_space(space)
        elsif (index + 1) % row_size == 0
          stringified_board << stringify_right_space(space)
        elsif ((board.size - row_size)..(board.size - 1)).include? index
          stringified_board << stringify_bottom_space(space)
        else
          stringified_board << stringify_space(space)
        end
      end
      stringified_board << "\n"
    end

    def self.stringify_space(space)
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
