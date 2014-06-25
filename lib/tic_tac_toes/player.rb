module TicTacToes
  class Player
    attr_reader :move_strategy, :token, :needs_to_think

    def initialize(move_strategy, token, needs_to_think, io_interface)
      @move_strategy = move_strategy
      @token = token
      @needs_to_think = needs_to_think
      @io_interface = io_interface
    end

    def place_and_return_move(board, players)
      loop do
        space = @move_strategy.move(board, players)
        break [@token, space] if board.place(self, space)
        @io_interface.invalid_move_error
      end
    end
  end
end
