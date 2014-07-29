require 'tic_tac_toes/test_board_generator'
require 'tic_tac_toes/core/move_strategies/hard_ai'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/player'

describe TicTacToes::Core::MoveStrategies::HardAI do
  let(:hard_ai) { TicTacToes::Core::MoveStrategies::HardAI }
  let(:x) { TicTacToes::Core::Player.new("human", "x", false, "io") }
  let(:o) { TicTacToes::Core::Player.new(hard_ai, "o", true, "io") }
  let(:players) { [o, x] }
  let(:history) { double(record_board_size: true) }


  describe '#move' do
    it "returns the best move" do
      board = TicTacToes::TestBoardGenerator.generate([x, nil, nil,
                                                       o,   o, nil,
                                                       x, nil,   x])
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      best_move = 5

      expect(hard_ai.move(game_state)).to eql(best_move)
    end

    context "when playing on a 3x3 board" do
      it 'returns 0 when making the first move' do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil, nil, nil,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)
        
        expect(hard_ai.move(game_state)).to eq(0)
      end

      it "returns 4 when the opponent’s first move was a corner" do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil, nil, nil,
                                                         nil, nil,   x])
        game_state = TicTacToes::Core::GameState.new(board, players, history)

        expect(hard_ai.move(game_state)).to eq(4)
      end
      
      it "returns 4 when the opponent’s first move was an edge" do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil, nil,   x,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)

        expect(hard_ai.move(game_state)).to eq(4)
      end

      it "returns 0 when the opponent’s first move was the center" do
        board = TicTacToes::TestBoardGenerator.generate([nil, nil, nil,
                                                         nil,   x, nil,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)

        expect(hard_ai.move(game_state)).to eq(0)
      end
    end
  end


  describe '#minimax' do
    it "returns the correct score for a pre-win board" do
      board = TicTacToes::TestBoardGenerator.generate([x, nil, nil,
                                                       o,   o, nil,
                                                       x, nil,   x])
      win_score = 1

      expect(hard_ai.minimax(board, :max, players)).to eql(win_score)
    end

    it "returns the correct score for a pre-loss board" do
      board = TicTacToes::TestBoardGenerator.generate([  o,   o,   x,
                                                       nil, nil, nil,
                                                         x, nil,   x])
      loss_score = -1

      expect(hard_ai.minimax(board, :max, players)).to eql(loss_score)
    end

    it "returns the correct score for a pre-draw board" do
      board = TicTacToes::TestBoardGenerator.generate([x,   x, o,
                                                       o, nil, x,
                                                       x,   o, x])
      draw_score = 0

      expect(hard_ai.minimax(board, :max, players)).to eql(draw_score)
    end
  end


  describe '#generate_board' do
    it "returns a board based on a token, a space, and an existing board" do
      token, space = o, 3
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil,   o, nil,
                                                         x, nil, nil])

      new_board = hard_ai.generate_board(token, space, board)
      expect(new_board.space(space)).to eql(token)
    end
  end


  describe '#score' do
    it "returns the correct score when HardAI has won" do
      board = TicTacToes::TestBoardGenerator.generate([  o, nil, nil,
                                                       nil,   o, nil,
                                                       nil, nil,   o])
      win_score = 1

      expect(hard_ai.score(board, players)).to eql(win_score)
    end

    it "returns the correct score when no one has won" do
      board = TicTacToes::TestBoardGenerator.generate([o, o, x,
                                                       x, x, o,
                                                       o, x, o])
      draw_score = 0

      expect(hard_ai.score(board, players)).to eql(draw_score)
    end

    it "returns the correct score when the opponent has won" do
      board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                       nil,   x, nil,
                                                       nil, nil,   x])
      loss_score = -1

      expect(hard_ai.score(board, players)).to eql(loss_score)
    end
  end
end
