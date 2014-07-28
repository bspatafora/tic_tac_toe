require 'tic_tac_toes/core/game_state_factory'

describe TicTacToes::Core::GameStateFactory do
  describe '#generate_game_state' do
    it 'returns a game state object generated from a board object and player array' do
      history = double(record_board_size: true)
      game_state_factory = TicTacToes::Core::GameStateFactory.new(history)
      board, players = double(size: 3), double

      game_state = game_state_factory.generate_game_state(board, players)
      expect(game_state.board).to eq(board)
      expect(game_state.players).to eq(players)
    end
  end
end
