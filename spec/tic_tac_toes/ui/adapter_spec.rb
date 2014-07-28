require 'tic_tac_toes/ui/adapter'

describe TicTacToes::UI::Adapter do
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
end
