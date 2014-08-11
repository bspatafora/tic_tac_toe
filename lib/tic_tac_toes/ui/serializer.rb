require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/player_factory'

module TicTacToes
  module UI
    module Serializer
      X = 'X'
      O = 'O'

      def self.new_board_structure
        board = Core::Board.new
        board.spaces
      end

      def self.game_state_from_board_structure(board_structure, computer_type)
        player_factory = Core::PlayerFactory.new('unused_io')
        human_player = player_factory.generate_player(X, Core::PlayerFactory::HUMAN)
        computer_player = player_factory.generate_player(O, Core::PlayerFactory.const_get(computer_type))
        players = [human_player, computer_player]

        board_structure_with_players = replace_tokens_with_players(board_structure, human_player, computer_player)
        board = board_from_structure(board_structure_with_players)

        Core::GameState.new(board, players, NullHistory.new)
      end

      def self.board_structure_from_game_state(game_state)
        structure_with_players = game_state.board.spaces

        replace_players_with_tokens(structure_with_players)
      end

      def self.computer_type_from_game_state(game_state)
        type = nil

        game_state.players.each do |player|
          if player.move_strategy == Core::PlayerFactory::AIS.fetch(Core::PlayerFactory::EASY_AI)
            type = 'EASY_AI'
          elsif player.move_strategy == Core::PlayerFactory::AIS.fetch(Core::PlayerFactory::MEDIUM_AI)
            type = 'MEDIUM_AI'
          elsif player.move_strategy == Core::PlayerFactory::AIS.fetch(Core::PlayerFactory::HARD_AI)
            type = 'HARD_AI'
          end
        end

        type
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

      def self.board_from_structure(board_structure)
        row_size = Math.sqrt(board_structure.count).to_i
        board = Core::Board.new(row_size: row_size)

        board_structure.each_with_index do |player, index|
          board.place(player, index)
        end

        board
      end
    end

    class NullHistory
      def record_board_size(size)
        nil
      end

      def record_move(move)
        nil
      end
    end
  end
end
