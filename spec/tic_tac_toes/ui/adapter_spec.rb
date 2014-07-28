require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/player_factory'
require 'tic_tac_toes/ui/adapter'

describe TicTacToes::UI::Adapter do
  describe '#new_board_structure' do
    it 'returns a new board structure' do
      new_board_structure = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      expect(TicTacToes::UI::Adapter.new_board_structure).to eq(new_board_structure)
    end
  end

  describe '#make_move' do
    context 'when the game is still in progress' do
      it 'sends its listener a `valid` message with an updated board structure' do
        board_structure = ["X", nil, nil, nil, "O", nil, nil, nil, nil]
        move = "2"
        listener = double

        updated_board_structure = ["X", "O", "X", nil, "O", nil, nil, nil, nil]

        expect(listener).to receive(:move_was_valid).with(updated_board_structure)
        TicTacToes::UI::Adapter.make_move(board_structure, move, listener)
      end
    end

    context 'when the game has ended' do
      it 'sends its listener a `game_over` message with an updated board structure and a game over message' do
        board_structure = ["X", "X", nil, nil, nil, nil, nil, nil, nil]
        move = "2"
        listener = double

        updated_board_structure = ["X", "X", "X", nil, nil, nil, nil, nil, nil]
        game_over_message = "Game over"

        expect(listener).to receive(:game_is_over).with(updated_board_structure, game_over_message)
        TicTacToes::UI::Adapter.make_move(board_structure, move, listener)
      end
    end
  end

  describe '#game_state_from_board_structure' do
    it 'returns a game state object based on a board structure' do
      board_structure = [nil, nil, nil, nil, "X", nil, nil, nil, nil]

      game_state = TicTacToes::UI::Adapter.game_state_from_board_structure(board_structure)
      middle_space = game_state.board.space(4)
      first_player = game_state.players.first
      second_player = game_state.players.last

      expect(middle_space.token).to eq('X')
      expect(first_player.token).to eq('X')
      expect(second_player.token).to eq('O')
    end
  end

  describe '#game_state_to_board_structure' do
    it 'returns a board structure based on a game state object' do
      player_factory = TicTacToes::Core::PlayerFactory.new('unused_io')
      first_player = player_factory.generate_human_player('X')
      second_player = player_factory.generate_computer_player('O', :hard)
      players = [first_player, second_player]
      board = TicTacToes::Core::Board.new
      board.place(first_player, 4)

      game_state = TicTacToes::Core::GameState.new(board, players, TicTacToes::UI::NullHistory.new)
      board_structure = [nil, nil, nil, nil, "X", nil, nil, nil, nil]
      expect(TicTacToes::UI::Adapter.game_state_to_board_structure(game_state)).to eq(board_structure)
    end
  end
end
