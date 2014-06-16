module TicTacToes
  class Player
    attr_reader :decider, :token, :needs_to_think

    def initialize(decider, token, needs_to_think, io_interface)
      @decider = decider
      @token = token
      @needs_to_think = needs_to_think
      @io_interface = io_interface
    end

    def make_move(board, players)
      loop do
        space = @decider.make_move(board, players)
        break [@token, space] if board.place(self, space)
        @io_interface.invalid_move_error
      end
    end
  end
end
