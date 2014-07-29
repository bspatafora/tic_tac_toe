module TicTacToes
  module Core
    class Player
      attr_reader :move_strategy, :token, :needs_to_think

      def initialize(move_strategy, token, needs_to_think, io)
        @move_strategy = move_strategy
        @token = token
        @needs_to_think = needs_to_think
        @io = io
      end

      def place_and_return_move(game_state)
        loop do
          space = @move_strategy.move(game_state)
          break [@token, space] if game_state.place_move(space)
          @io.invalid_move_error
        end
      end
    end
  end
end
