module TicTacToe
  class History
    attr_reader :board_size, :moves, :winner

    def record_board_size(size)
      @board_size = size
    end

    def record_move(token, space)
      @moves ||= []
      @moves << [token, space]
    end

    def record_winner(token)
      @winner = token
    end
  end
end
