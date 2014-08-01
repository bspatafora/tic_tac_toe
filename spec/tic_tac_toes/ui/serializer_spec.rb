require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/player_factory'
require 'tic_tac_toes/ui/serializer'

describe TicTacToes::UI::Serializer do
  describe '#new_board_structure' do
    it 'returns a new board structure' do
      new_board_structure = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      expect(TicTacToes::UI::Serializer.new_board_structure).to eq(new_board_structure)
    end
  end

  describe '#game_state_from_board_structure' do
    it 'returns a game state object based on a board structure' do
      board_structure = [nil, nil, nil, nil, 'X', nil, nil, nil, nil]

      game_state = TicTacToes::UI::Serializer.game_state_from_board_structure(board_structure)
      middle_space = game_state.board.space(4)
      first_player = game_state.players.first
      second_player = game_state.players.last

      expect(middle_space.token).to eq(TicTacToes::UI::Serializer::X)
      expect(first_player.token).to eq(TicTacToes::UI::Serializer::X)
      expect(second_player.token).to eq(TicTacToes::UI::Serializer::O)
    end
  end

  describe '#game_state_to_board_structure' do
    it 'returns a board structure based on a game state object' do
      player_factory = TicTacToes::Core::PlayerFactory.new('unused_io')
      first_player = player_factory.generate_player(TicTacToes::UI::Serializer::X, TicTacToes::Core::PlayerFactory::HUMAN)
      second_player = player_factory.generate_player(TicTacToes::UI::Serializer::O, TicTacToes::Core::PlayerFactory::HARD_AI)
      players = [first_player, second_player]
      board = TicTacToes::Core::Board.new
      board.place(first_player, 4)

      game_state = TicTacToes::Core::GameState.new(board, players, TicTacToes::UI::NullHistory.new)
      board_structure = [nil, nil, nil, nil, 'X', nil, nil, nil, nil]
      expect(TicTacToes::UI::Serializer.game_state_to_board_structure(game_state)).to eq(board_structure)
    end
  end
end
