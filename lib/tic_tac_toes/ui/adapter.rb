require 'tic_tac_toes/core/player_factory'
require 'tic_tac_toes/core/move_strategies/hard_ai'
require 'tic_tac_toes/core/move_strategies/types'
require 'tic_tac_toes/database/pg_wrapper'

require 'tic_tac_toes/command_line/history_reader'

module TicTacToes
  module UI
    module Adapter
      def self.start_game(order, game_state, listener)
        user_is_first = order == 'first'

        user_is_first ? listener.moves_were_made(game_state) : make_move(game_state, nil, listener)
      end

      def self.make_move(game_state, move, listener)
        computer_first = move.nil?

        if computer_first
          game_state.turn_over(nil)
          computer_move(game_state, listener)
          return game_over(game_state, listener) if game_state.game_over?
        else
          human_move(game_state, move, listener)
          return game_over(game_state, listener) if game_state.game_over?
          computer_move(game_state, listener)
          return game_over(game_state, listener) if game_state.game_over?
        end
        listener.moves_were_made(game_state)
      end

      def self.predictions(game_state)
        predictions = []
        (0..8).each do |space|
          next predictions << nil unless game_state.board.space(space).nil?

          potential_game_state = generate_game_state(game_state, space)
          next predictions << predicted_result(potential_game_state) if potential_game_state.game_over?

          potential_game_state.turn_over(nil)
          potential_game_state.place_move(Core::MoveStrategies::HardAI.move(potential_game_state))
          next predictions << predicted_result(potential_game_state) if potential_game_state.game_over?

          predictions << nil
        end
        predictions
      end

      private

      def self.computer_move(game_state, listener)
        computer_player = game_state.computer_player
        computer_move = computer_player.place_and_return_move(game_state)
        game_state.turn_over(computer_move)
      end

      def self.human_move(game_state, move, listener)
        human_player = game_state.current_player
        game_state.place_move(move.to_i)
        game_state.turn_over([human_player.token, move.to_i])
      end

      def self.game_over(game_state, listener)
        winning_player = game_state.determine_winner

        record_game_history(game_state, winning_player)
        if winning_player
          listener.game_ended_in_winner(game_state, winning_player.token)
        else
          listener.game_ended_in_draw(game_state)
        end
      end

      def self.record_game_history(game_state, winning_player)
        game_state.start_game
        game_state.end_game(winning_player)
      end

      def self.generate_game_state(game_state, space)
        new_game_state = Marshal.load(Marshal.dump(game_state))
        new_game_state.place_move(space)
        new_game_state
      end

      def self.predicted_result(game_state)
        winner = game_state.determine_winner

        if winner.nil?
          "tie"
        elsif winner.move_strategy.type == Core::MoveStrategies::HUMAN
          "win"
        else
          "loss"
        end
      end
    end
  end
end
