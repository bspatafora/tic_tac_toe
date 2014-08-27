require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/player_factory'
require 'tic_tac_toes/database/pg_wrapper'

module TicTacToes
  module UI
    module Serializer
      X = 'X'
      O = 'O'

      def self.new_board_structure
        board = Core::Board.new
        board.spaces
      end

      def self.game_state(board_structure, computer_type, move_history)
        player_factory = Core::PlayerFactory.new('unused_io')
        human_player = player_factory.generate_player(X, Core::PlayerFactory::HUMAN)
        computer_player = player_factory.generate_player(O, Core::PlayerFactory.const_get(computer_type))
        players = [human_player, computer_player]

        board_structure_with_players = replace_tokens_with_players(board_structure, human_player, computer_player)
        board = board(board_structure_with_players)

        history = history(move_history)

        Core::GameState.new(board, players, history)
      end

      def self.board_structure(game_state)
        structure_with_players = game_state.board.spaces
        replace_players_with_tokens(structure_with_players)
      end

      def self.ai_type(game_state)
        computer = Core::MoveStrategies::COMPUTER
        computer_player = game_state.players.detect { |player| player.move_strategy.type == computer }
        computer_player.move_strategy.ai_type
      end

      def self.move_history(game_state)
        game_state.moves.flatten.join if game_state.moves
      end

      private

      def self.replace_tokens_with_players(board_structure, human_player, computer_player)
        board_structure.map do |space|
          case space
          when X
            human_player
          when O
            computer_player
          else
            nil
          end
        end
      end

      def self.replace_players_with_tokens(board_structure)
        board_structure.map { |space| space.token unless space.nil? }
      end

      def self.board(board_structure)
        row_size = Math.sqrt(board_structure.count).to_i
        board = Core::Board.new(row_size: row_size)

        board_structure.each_with_index do |player, index|
          board.place(player, index)
        end

        board
      end

      def self.history(move_history)
        storage_wrapper = Database::PGWrapper.new('tic_tac_toes')
        history = Core::History.new(storage_wrapper)
        if move_history
          moves = move_history.split(//).each_slice(2).to_a
          moves.each do |move|
            move = [move.first, move.last.to_i]
            history.record_move(move)
          end
        end
        history
      end
    end

    class NullHistory
      def record_board_size(size)
        nil
      end

      def record_difficulty(difficulty)
        nil
      end

      def record_move(move)
        nil
      end

      def record_winner(winner)
        nil
      end

      def persist
        nil
      end
    end
  end
end
