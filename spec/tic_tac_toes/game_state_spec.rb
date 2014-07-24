require 'tic_tac_toes/game_state'
require 'test_board_generator'

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

  describe '#game_over?' do
    let(:x) { double("human player", token: "x") }
    let(:o) { double("computer player", token: "o") }
    let(:players) { [x, o] }

    let(:history) { double(record_board_size: true) }

    it "returns false if there is not yet a winner and the board is not full" do
      board = TestBoardGenerator.generate([x, x,   o,
                                           o, o, nil,
                                           x, o,   x])
      game_state = TicTacToes::GameState.new(board, players, history)
      expect(game_state.game_over?).to be false
    end

    it "returns true if any player has won" do
      board = TestBoardGenerator.generate([  x, nil, nil,
                                           nil,   x, nil,
                                           nil, nil,   x])

      game_state = TicTacToes::GameState.new(board, players, history)

      expect(game_state.game_over?).to be true
    end

    it "returns true if the board is full" do
      board = TestBoardGenerator.generate([x, x, o,
                                           o, o, x,
                                           x, o, x])

      game_state = TicTacToes::GameState.new(board, players, history)
      expect(game_state.game_over?).to be true
    end
  end

  describe '#determine_winner' do
    let(:x) { double("human player", token: "x") }
    let(:o) { double("computer player", token: "o") }
    let(:players) { [x, o] }

    let(:history) { double(record_board_size: true) }
    it "returns the winning token when there is a winner" do
      board = TestBoardGenerator.generate([  o, nil, nil,
                                           nil,   o, nil,
                                           nil, nil,   o])
      winning_token = "o"
      game_state = TicTacToes::GameState.new(board, players, history)

      expect(game_state.determine_winner).to eql(winning_token)
    end

    it "returns nil if there is not a winner" do
      board = TestBoardGenerator.generate([x, x,   o,
                                           o, o, nil,
                                           x, o,   x])
      game_state = TicTacToes::GameState.new(board, players, history)

      expect(game_state.determine_winner).to be_nil
    end
  end

end
