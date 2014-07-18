require 'tic_tac_toes/board'
require 'tic_tac_toes/game_state'
require 'tic_tac_toes/player_factory'
require 'tic_tac_toes/rules'

module UI
  module Adapter
    def self.new_board_structure
      board = TicTacToes::Board.new
      board.spaces
    end

    def self.move_made(board_structure, move, listener)
      move = move.to_i
      game_state = game_state_from_board_structure(board_structure)

      human_player = game_state.players.first
      game_state.board.place(human_player, move)

      if TicTacToes::Rules.game_over?(game_state.board, game_state.players)
        return listener.game_over(game_state_to_board_structure(game_state), "Game over")
      end

      game_state.turn_over(move)

      computer_player = game_state.players.first
      computer_player.place_and_return_move(game_state.board, game_state.players)

      if TicTacToes::Rules.game_over?(game_state.board, game_state.players)
        return listener.game_over(game_state_to_board_structure(game_state), "Game over")
      end

      listener.valid(game_state_to_board_structure(game_state))
    end

    def self.game_state_from_board_structure(board_structure)
      player_factory = TicTacToes::PlayerFactory.new('unused_io')
      human_player = player_factory.generate_human_player('X')
      computer_player = player_factory.generate_computer_player('O', :hard)
      players = [human_player, computer_player]

      board_structure_with_players = replace_tokens_with_players(board_structure, human_player, computer_player)
      board = board_from_structure(board_structure_with_players)

      TicTacToes::GameState.new(board, players, NullHistory.new)
    end

    def self.game_state_to_board_structure(game_state)
      structure_with_players = game_state.board.spaces

      replace_players_with_tokens(structure_with_players)
    end

    private

    def self.replace_tokens_with_players(board_structure, human_player, computer_player)
      board_structure.map do |space|
        case space
        when 'X'
          human_player
        when 'O'
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
      board = TicTacToes::Board.new(row_size: row_size)

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
