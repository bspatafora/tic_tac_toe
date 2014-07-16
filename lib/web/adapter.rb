require 'json'
require 'tic_tac_toes/board'
require 'tic_tac_toes/game_state'
require 'tic_tac_toes/player_factory'

module Web
  class NullHistory
    def record_board_size(size)
      nil
    end
  end

  module Adapter
    def self.new_game_state_json
      game_state_structure = { 'spaces' => Array.new(9), 'tokens' => ['X', 'O'] }
      JSON.generate(game_state_structure)
    end

    def self.game_state_from_json(game_state_json)
      game_state_structure = JSON.parse(game_state_json)
      human_token, computer_token = game_state_structure['tokens']
      spaces_with_tokens = game_state_structure['spaces']

      player_factory = TicTacToes::PlayerFactory.new('unused_io')
      human_player = player_factory.generate_human_player(human_token)
      computer_player = player_factory.generate_computer_player(computer_token, :hard)
      players = [human_player, computer_player]

      spaces_with_players = replace_tokens_with_players(spaces_with_tokens, human_player, computer_player)
      board = board_from_spaces(spaces_with_players)

      TicTacToes::GameState.new(board, players, NullHistory.new)
    end

    def self.game_state_to_json(game_state)
      spaces_with_players = game_state.board.spaces
      spaces_with_tokens = replace_players_with_tokens(spaces_with_players)
      tokens = game_state.players.map { |player| player.token }

      game_state_structure = { 'spaces' => spaces_with_tokens, 'tokens' => tokens }
      JSON.generate(game_state_structure)
    end

    private

    def self.replace_tokens_with_players(spaces, human_player, computer_player)
      spaces.map do |space|
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

    def self.replace_players_with_tokens(spaces)
      spaces.map { |space| space.token unless space.nil? }
    end

    def self.board_from_spaces(spaces)
      row_size = Math.sqrt(spaces.count).to_i
      board = TicTacToes::Board.new(row_size: row_size)

      spaces.each_with_index do |player, index|
        board.place(player, index)
      end

      board
    end
  end
end
