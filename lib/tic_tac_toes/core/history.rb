module TicTacToes
  module Core
    class History
      attr_reader :board_size, :difficulty, :moves, :winner

      def initialize(wrapper)
        @wrapper = wrapper
      end

      def record_board_size(size)
        @board_size = size
      end

      def record_difficulty(difficulty)
        @difficulty = difficulty.to_s
      end

      def record_move(move)
        @moves ||= []
        @moves << move
      end

      def record_winner(winner)
        winner = 'Draw' if winner.nil?
        winner = winner.token unless winner.is_a? String
        @winner = winner
      end

      def persist
        @wrapper.record_game_history(self)
      end
    end
  end
end
