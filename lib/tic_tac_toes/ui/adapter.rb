require 'tic_tac_toes/core/player_factory'
require 'tic_tac_toes/core/move_strategies/hard_ai'

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

      def self.predictions(game_state)
        predictions = []
        (0..8).each do |space|
          next predictions << nil unless game_state.board.space(space).nil?

          potential_game_state = generate_game_state(game_state, space)
          next predictions << predicted_result(potential_game_state) if potential_game_state.game_over?

          potential_game_state.turn_over([])
          potential_game_state.place_move(Core::MoveStrategies::HardAI.move(potential_game_state))
          next predictions << predicted_result(potential_game_state) if potential_game_state.game_over?

          predictions << nil
        end
        predictions
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

      def self.generate_game_state(game_state, space)
        new_game_state = Marshal.load(Marshal.dump(game_state))
        new_game_state.turn_over([])
        new_game_state.place_move(space)
        new_game_state
      end

      def self.predicted_result(game_state)
        winner = game_state.determine_winner

        if winner.nil?
          "tie"
        elsif winner.move_strategy.is_a? Core::MoveStrategies::Human
          "win"
        else
          "loss"
        end
      end
    end
  end
end
