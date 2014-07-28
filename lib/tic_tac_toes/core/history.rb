module TicTacToes
  module Core
    class History
      attr_reader :board_size, :moves, :winner

      def initialize(database_wrapper)
        @database_wrapper = database_wrapper
      end

      def record_board_size(size)
        @board_size = size
      end

      def record_move(move)
        @moves ||= []
        @moves << move
      end

      def record_winner(winner)
        winner = "Draw" if winner.nil?
        @winner = winner
      end

      def persist
        @database_wrapper.record_game_history(self)
      end
    end
  end
end
