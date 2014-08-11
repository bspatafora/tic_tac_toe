module TicTacToes
  module UI
    module Adapter
      def self.start_game(order, game_state, listener)
        case order
        when 'first'
          listener.moves_were_made(game_state)
        when 'second'
          make_move(game_state, nil, listener)
        end
      end

      def self.make_move(game_state, move, listener)
        unless move.nil?
          move = move.to_i
          game_state.place_move(move)
        end

        if game_state.game_over?
          tell_listener_game_is_over(game_state, listener)
          return
        end

        game_state.turn_over(move)
        game_state.current_player.place_and_return_move(game_state)

        if game_state.game_over?
          tell_listener_game_is_over(game_state, listener)
          return
        end

        listener.moves_were_made(game_state)
      end

      private

      def self.tell_listener_game_is_over(game_state, listener)
        winning_player = game_state.determine_winner

        case winning_player
        when nil
          listener.game_ended_in_draw(game_state)
        else 
          listener.game_ended_in_winner(game_state, winning_player.token)
        end
      end
    end
  end
end
