require 'tic_tac_toes/core/rules'
require 'tic_tac_toes/ui/serializer'

module TicTacToes
  module UI
    module Adapter
      def self.make_move(board_structure, move, listener)
        move = move.to_i
        game_state = UI::Serializer.game_state_from_board_structure(board_structure)

        human_player = game_state.players.first
        game_state.board.place(human_player, move)

        if Core::Rules.game_over?(game_state.board, game_state.players)
          return listener.game_is_over(UI::Serializer.game_state_to_board_structure(game_state), "Game over")
        end

        game_state.turn_over(move)

        computer_player = game_state.players.first
        computer_player.place_and_return_move(game_state.board, game_state.players)

        if Core::Rules.game_over?(game_state.board, game_state.players)
          return listener.game_is_over(UI::Serializer.game_state_to_board_structure(game_state), "Game over")
        end

        listener.move_was_valid(UI::Serializer.game_state_to_board_structure(game_state))
      end
    end
  end
end
