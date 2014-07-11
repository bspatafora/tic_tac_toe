require 'tic_tac_toes/game_state'

describe TicTacToes::GameState do
  describe '@initialize' do
    it "records its board's size" do
      size = 5
      board = double(size: size)
      history = double

      expect(history).to receive(:record_board_size).with(size)
      TicTacToes::GameState.new(board, 'players', history)
    end
  end

  describe '#current_player' do
    it 'returns the first item of its players array' do
      history = double(record_board_size: true)
      players = ['first_player', 'second_player']
      game_state = TicTacToes::GameState.new('board', players, history)

      current_player = game_state.current_player
      expect(current_player).to eq('first_player')
    end
  end

  describe '#turn_over' do
    it 'records the last move' do
      move = double
      players = double(rotate!: true)
      history = double(record_board_size: true)
      game_state = TicTacToes::GameState.new('board', players, history)

      expect(history).to receive(:record_move).with(move)
      game_state.turn_over(move)
    end

    it 'rotates its player array' do
      players = ['first_player', 'second_player']
      history = double(record_board_size: true, record_move: true)
      game_state = TicTacToes::GameState.new('board', players, history)

      game_state.turn_over('move')
      expect(game_state.current_player).to eq('second_player')
    end
  end

  describe '#game_over' do
    it 'records the winner' do
      winner = double
      history = double(record_board_size: true, persist: true)
      game_state = TicTacToes::GameState.new('board', 'players', history)

      expect(history).to receive(:record_winner).with(winner)
      game_state.game_over(winner)
    end

    it 'persists its history' do
      winner = double
      history = double(record_board_size: true, record_winner: true)
      game_state = TicTacToes::GameState.new('board', 'players', history)

      expect(history).to receive(:persist)
      game_state.game_over(winner)
    end
  end
end
