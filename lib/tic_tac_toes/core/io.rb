require 'tic_tac_toes/core/presenter'

module TicTacToes
  module Core
    class IO
      def initialize(io_strategy)
        @io_strategy = io_strategy
      end

      def get_row_size
        row_size_solicitation

        Integer(@io_strategy.solicit_input)
        rescue ArgumentError
          not_an_integer_error
          get_row_size
      end

      def get_token(player)
        token_solicitation(player)
        @io_strategy.solicit_input
      end

      def get_difficulty
        difficulty_solicitation
        @io_strategy.solicit_input.downcase.to_sym
      end

      def draw_board(board)
        @io_strategy.display(Presenter.board(board))
      end

      def invalid_row_size_error
        @io_strategy.display_red(Presenter::INVALID_ROW_SIZE)
      end

      def invalid_token_error
        @io_strategy.display_red(Presenter::INVALID_TOKEN)
      end

      def invalid_difficulty_error
        @io_strategy.display_red(Presenter::INVALID_DIFFICULTY)
      end

      def invalid_move_error
        @io_strategy.display_red(Presenter::INVALID_MOVE)
      end

      def thinking_notification
        @io_strategy.display_red(Presenter::THINKING)
      end

      def game_over_notification(winner)
        winner = "Nobody" if winner.nil?
        winner = winner.token unless winner.is_a? String
        @io_strategy.display(Presenter.game_over_notification(winner))
      end

      def move_solicitation
        @io_strategy.display(Presenter::MOVE_SOLICITATION)
      end

      def not_an_integer_error
        @io_strategy.display_red(Presenter::NOT_AN_INTEGER)
      end

      def solicit_input
        @io_strategy.solicit_input
      end

      def red(message)
        @io_strategy.red(message)
      end

      def blue(message)
        @io_strategy.blue(message)
      end

      private

      def row_size_solicitation
        @io_strategy.display(Presenter::ROW_SIZE_SOLICITATION)
      end

      def token_solicitation(player)
        @io_strategy.display(Presenter.token_solicitation(player))
      end

      def difficulty_solicitation
        @io_strategy.display(Presenter::DIFFICULTY_SOLICITATION)
      end
    end
  end
end
