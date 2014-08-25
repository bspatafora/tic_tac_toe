require 'tic_tac_toes/core/game_state'

module TicTacToes
  module CommandLine
    class Runner
      def initialize(io, menu, history)
        @io = io
        @menu = menu
        @history = history
      end

      def run
        board, players = @menu.get_board, @menu.get_players
        game_state = TicTacToes::Core::GameState.new(board, players, @history)
        game_state.start_game

        take_turn(game_state) until game_state.game_over?
        end_game(game_state)
      end

      private

      def take_turn(game_state)
        @io.draw_board(game_state.board)
        @io.thinking_notification if game_state.current_player.needs_to_think

        move = game_state.current_player.place_and_return_move(game_state)
        game_state.turn_over(move)
      end

      def end_game(game_state)
        @io.draw_board(game_state.board)

        winner = game_state.determine_winner
        game_state.end_game(winner)

        @io.game_over_notification(winner)
      end
    end
  end
end
