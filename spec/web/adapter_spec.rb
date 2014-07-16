require 'tic_tac_toes/board'
require 'tic_tac_toes/game_state'
require 'tic_tac_toes/player_factory'
require 'web/adapter'

describe Web::Adapter do
  describe '#new_game_state_json' do
    it 'returns a JSON game state structure' do
      game_state_json = "{\"spaces\":[null,null,null,null,null,null,null,null,null],\"tokens\":[\"X\",\"O\"]}"
      expect(Web::Adapter.new_game_state_json).to eq(game_state_json)
    end
  end

  describe '#game_state_from_json' do
    it 'returns a game state object based on a json structure' do
      game_state_json = "{\"spaces\":[null,null,null,null,\"X\",null,null,null,null],\"tokens\":[\"X\",\"O\"]}"

      game_state = Web::Adapter.game_state_from_json(game_state_json)
      middle_space = game_state.board.space(4)
      first_player = game_state.players.first
      second_player = game_state.players.last

      expect(middle_space.token).to eq('X')
      expect(first_player.token).to eq('X')
      expect(second_player.token).to eq('O')
    end
  end

  describe '#game_state_to_json' do
    it 'returns a JSON game state structure based on a game state object' do
      player_factory = TicTacToes::PlayerFactory.new('unused_io')
      first_player = player_factory.generate_human_player('X')
      second_player = player_factory.generate_computer_player('O', :hard)
      players = [first_player, second_player]
      board = TicTacToes::Board.new
      board.place(first_player, 4)

      game_state = TicTacToes::GameState.new(board, players, Web::NullHistory.new)
      game_state_json = "{\"spaces\":[null,null,null,null,\"X\",null,null,null,null],\"tokens\":[\"X\",\"O\"]}"
      expect(Web::Adapter.game_state_to_json(game_state)).to eq(game_state_json)
    end
  end
end
