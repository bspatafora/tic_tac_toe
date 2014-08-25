require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/move_strategies/medium_ai'
require 'tic_tac_toes/core/player_factory'
require 'tic_tac_toes/test_board_generator'

describe TicTacToes::Core::GameState do
  describe '#start_game' do
    it "records the board size" do
      size = 5
      board = double(size: size)
      player = TicTacToes::Core::PlayerFactory.new('unused_io').generate_player('x', :medium)
      players = [player]
      history = double

      allow(history).to receive(:record_difficulty)
      expect(history).to receive(:record_board_size).with(size)
      TicTacToes::Core::GameState.new(board, players, history).start_game
    end

    it "records the AI difficulty" do
      board = double(size: true)
      computer_player = TicTacToes::Core::PlayerFactory.new('unused_io').generate_player('x', :medium)
      human_player = TicTacToes::Core::PlayerFactory.new('unused_io').generate_player('o', :human)
      players = [computer_player, human_player]
      ai = TicTacToes::Core::MoveStrategies::MediumAI
      history = double

      allow(history).to receive(:record_board_size)
      expect(history).to receive(:record_difficulty).with(ai)
      TicTacToes::Core::GameState.new(board, players, history).start_game
    end
  end

  describe '#place_move' do
    let(:x) { double("human player", token: "x") }
    let(:o) { double("computer player", token: "o") }
    let(:players) { [x, o] }

    let(:history) { double(record_board_size: true) }

    it 'returns nil if the board’s space is not nil' do
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil, nil, nil,
                                                       nil, nil, nil])
      game_state = TicTacToes::Core::GameState.new(board, players, history)

      expect(game_state.place_move(0)).to eq(nil)
    end

    it 'returns nil if it isn’t in its board’s spaces range' do
      board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                       nil, nil, nil,
                                                       nil, nil, nil])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      expect(game_state.place_move(9)).to eq(nil)
    end

    it 'places the current player at the space if the space is nil and in the board’s spaces range' do
      board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                       nil, nil, nil,
                                                       nil, nil, nil])
      game_state = TicTacToes::Core::GameState.new(board, players, history)

      game_state.place_move(0)
      expect(game_state.board.space(0)).to eq(game_state.current_player)
    end
  end

  describe '#current_player' do
    it 'returns the first item of its players array' do
      history = double(record_board_size: true)
      players = ['first_player', 'second_player']
      game_state = TicTacToes::Core::GameState.new('board', players, history)

      current_player = game_state.current_player
      expect(current_player).to eq('first_player')
    end
  end

  describe '#next_player' do
    it 'returns the second item of its players array' do
      history = double(record_board_size: true)
      players = ['first_player', 'second_player']
      game_state = TicTacToes::Core::GameState.new('board', players, history)

      next_player = game_state.next_player
      expect(next_player).to eq('second_player')
    end
  end

  describe '#turn_over' do
    it 'records the last move' do
      move = double
      players = double(rotate!: true)
      history = double(record_board_size: true)
      game_state = TicTacToes::Core::GameState.new('board', players, history)

      expect(history).to receive(:record_move).with(move)
      game_state.turn_over(move)
    end

    it 'rotates its player array' do
      players = ['first_player', 'second_player']
      history = double(record_board_size: true, record_move: true)
      game_state = TicTacToes::Core::GameState.new('board', players, history)

      game_state.turn_over('move')
      expect(game_state.current_player).to eq('second_player')
    end
  end

  describe '#end_game' do
    it 'records the winner' do
      winning_player = double
      history = double(record_board_size: true, persist: true)
      game_state = TicTacToes::Core::GameState.new('board', 'players', history)

      expect(history).to receive(:record_winner).with(winning_player)
      game_state.end_game(winning_player)
    end

    it 'persists its history' do
      winning_player = double(token: 'x')
      history = double(record_board_size: true, record_winner: true)
      game_state = TicTacToes::Core::GameState.new('board', 'players', history)

      expect(history).to receive(:persist)
      game_state.end_game(winning_player)
    end
  end

  describe '#game_over?' do
    let(:x) { double("human player", token: "x") }
    let(:o) { double("computer player", token: "o") }
    let(:players) { [x, o] }

    let(:history) { double(record_board_size: true) }

    it "returns false if there is not yet a winner and the board is not full" do
      board = TicTacToes::TestBoardGenerator.generate([x, x,   o,
                                                       o, o, nil,
                                                       x, o,   x])

      game_state = TicTacToes::Core::GameState.new(board, players, history)
      expect(game_state.game_over?).to be false
    end

    it "returns true if any player has won" do
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil,   x, nil,
                                                       nil, nil,   x])

      game_state = TicTacToes::Core::GameState.new(board, players, history)

      expect(game_state.game_over?).to be true
    end

    it "returns true if the board is full" do
      board = TicTacToes::TestBoardGenerator.generate([x, x, o,
                                                       o, o, x,
                                                       x, o, x])

      game_state = TicTacToes::Core::GameState.new(board, players, history)
      expect(game_state.game_over?).to be true
    end
  end

  describe '#determine_winner' do
    let(:x) { double("human player", token: "x") }
    let(:o) { double("computer player", token: "o") }
    let(:players) { [x, o] }

    let(:history) { double(record_board_size: true) }
    it "returns the winning token when there is a winner" do
      board = TicTacToes::TestBoardGenerator.generate([  o, nil, nil,
                                                       nil,   o, nil,
                                                       nil, nil,   o])
      winning_token = "o"
      game_state = TicTacToes::Core::GameState.new(board, players, history)

      winning_player = game_state.determine_winner
      expect(winning_player.token).to eq(winning_token)
    end

    it "returns nil if there is not a winner" do
      board = TicTacToes::TestBoardGenerator.generate([x, x,   o,
                                                       o, o, nil,
                                                       x, o,   x])
      game_state = TicTacToes::Core::GameState.new(board, players, history)

      expect(game_state.determine_winner).to be_nil
    end
  end
end
