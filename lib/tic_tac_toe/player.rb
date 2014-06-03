module TicTacToe
  class Player
    attr_reader :decider, :token, :needs_to_think

    def initialize(decider, token, needs_to_think, io)
      @decider = decider
      @token = token
      @needs_to_think = needs_to_think
      @io = io
    end

    def make_move(board, players)
      loop do
        space = @decider.make_move(board, players)
        break if board.place(@token, space)
        @io.invalid_move_error
      end
    end
  end
end
