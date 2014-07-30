require 'tic_tac_toes/test_board_generator'
require 'tic_tac_toes/core/move_strategies/hard_ai'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/player'

describe TicTacToes::Core::MoveStrategies::HardAI do
  let(:alpha) { TicTacToes::Core::MoveStrategies::HardAI::ALPHA }
  let(:beta) { TicTacToes::Core::MoveStrategies::HardAI::BETA }
  let(:hard_ai) { TicTacToes::Core::MoveStrategies::HardAI }
  let(:x) { TicTacToes::Core::Player.new("human", "x", false, "io") }
  let(:o) { TicTacToes::Core::Player.new(hard_ai, "o", true, "io") }
  let(:players) { [o, x] }
  let(:history) { TicTacToes::UI::NullHistory.new }

  describe '#move' do
    it 'returns the best move' do
      board = TicTacToes::TestBoardGenerator.generate([x, nil, nil,
                                                       o,   o, nil,
                                                       x, nil,   x])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      best_move = 5

      expect(hard_ai.move(game_state)).to eql(best_move)
    end

    context 'when playing on a 3x3 board' do
      it 'returns 0 when making the first move' do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil, nil, nil,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)
        
        expect(hard_ai.move(game_state)).to eq(0)
      end

      it 'returns 4 when the opponent’s first move was a corner' do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil, nil, nil,
                                                         nil, nil,   x])
        game_state = TicTacToes::Core::GameState.new(board, players, history)

        expect(hard_ai.move(game_state)).to eq(4)
      end
      
      it 'returns 4 when the opponent’s first move was an edge' do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil, nil,   x,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)

        expect(hard_ai.move(game_state)).to eq(4)
      end

      it 'returns 0 when the opponent’s first move was the center' do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil,   x, nil,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)

        expect(hard_ai.move(game_state)).to eq(0)
      end
    end
  end


  describe '#minimax' do
    it 'returns the correct score for a pre-win board' do
      board = TicTacToes::TestBoardGenerator.generate([x, nil, nil,
                                                       o,   o, nil,
                                                       x, nil,   x])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      win_score = 1

      expect(hard_ai.minimax(game_state, :max, alpha, beta)).to eql(win_score)
    end

    it 'returns the correct score for a pre-loss board' do
      board = TicTacToes::TestBoardGenerator.generate([  o,   o,   x,
                                                       nil, nil, nil,
                                                         x, nil,   x])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      loss_score = -1

      expect(hard_ai.minimax(game_state, :max, alpha, beta)).to eql(loss_score)
    end

    it 'returns the correct score for a pre-draw board' do
      board = TicTacToes::TestBoardGenerator.generate([x,   x, o,
                                                       o, nil, x,
                                                       x,   o, x])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      draw_score = 0

      expect(hard_ai.minimax(game_state, :max, alpha, beta)).to eql(draw_score)
    end
  end


  describe '#generate_game_state' do
    it 'returns a game state based on a space and an existing game state' do
      space, token = 3, 'o'
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil,   o, nil,
                                                         x, nil, nil])
      game_state = TicTacToes::Core::GameState.new(board, players, history)

      new_game_state = hard_ai.generate_game_state(space, game_state)
      expect(new_game_state.board.space(space).token).to eq(token)
    end
  end


  describe '#score' do
    it 'returns the correct score when HardAI has won' do
      board = TicTacToes::TestBoardGenerator.generate([  o, nil, nil,
                                                       nil,   o, nil,
                                                       nil, nil,   o])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      win_score = 1

      expect(hard_ai.score(game_state)).to eq(win_score)
    end

    it 'returns the correct score when no one has won' do
      board = TicTacToes::TestBoardGenerator.generate([o, o, x,
                                                       x, x, o,
                                                       o, x, o])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      draw_score = 0

      expect(hard_ai.score(game_state)).to eql(draw_score)
    end

    it 'returns the correct score when the opponent has won' do
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil,   x, nil,
                                                       nil, nil,   x])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      loss_score = -1

      expect(hard_ai.score(game_state)).to eql(loss_score)
    end
  end
end
