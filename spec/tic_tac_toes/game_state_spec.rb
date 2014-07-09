require 'tic_tac_toes/game_state'

describe TicTacToes::GameState do
  describe '#current_player' do
    it 'returns the first item of its players array' do
      players = ['first_player', 'second_player']
      game_state = TicTacToes::GameState.new('board', players, 'history')

      current_player = game_state.current_player
      expect(current_player).to eq('first_player')
    end
  end

  describe '#turn_over' do
    it 'records the last move' do
      move = double
      players = double(rotate!: true)
      history = double
      game_state = TicTacToes::GameState.new('board', players, history)

      expect(history).to receive(:record_move).with(move)
      game_state.turn_over(move)
    end

    it 'rotates its player array' do
      players = ['first_player', 'second_player']
      history = double(record_move: true)
      game_state = TicTacToes::GameState.new('board', players, history)

      game_state.turn_over('move')
      expect(game_state.current_player).to eq('second_player')
    end
  end

  describe '#game_over' do
    it 'records the winner' do
      winner = double
      history = double
      game_state = TicTacToes::GameState.new('board', 'players', history)

      expect(history).to receive(:record_winner).with(winner)
      game_state.game_over(winner)
    end
  end
end
