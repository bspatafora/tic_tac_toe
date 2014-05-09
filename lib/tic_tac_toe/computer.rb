module TicTacToe
  class Computer
    def initialize(game)
      @board = game.board
    end

    def make_move
      @board.each_with_index { |space, index| return index if space.nil? }
    end
  end
end
