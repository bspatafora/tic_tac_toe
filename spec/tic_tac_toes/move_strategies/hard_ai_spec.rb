require 'test_board_generator'
require 'tic_tac_toes/move_strategies/hard_ai'
require 'tic_tac_toes/player'

describe TicTacToes::MoveStrategies::HardAI do
  let(:hard_ai) { TicTacToes::MoveStrategies::HardAI }
  let(:x) { TicTacToes::Player.new("human", "x", false, "io") }
  let(:o) { TicTacToes::Player.new(hard_ai, "o", true, "io") }
  let(:players) { [o, x] }


  describe '#move' do
    it "returns the best move" do
      board = TestBoardGenerator.generate([x, nil, nil,
                                           o,   o, nil,
                                           x, nil,   x])
      best_move = 5

      expect(hard_ai.move(board, players)).to eql(best_move)
    end
  end


  describe '#minimax' do
    it "returns the correct score for a pre-win board" do
      board = TestBoardGenerator.generate([x, nil, nil,
                                           o,   o, nil,
                                           x, nil,   x])
      win_score = 1

      expect(hard_ai.minimax(board, :max, players)).to eql(win_score)
    end

    it "returns the correct score for a pre-loss board" do
      board = TestBoardGenerator.generate([  o,   o,   x,
                                           nil, nil, nil,
                                             x, nil,   x])
      loss_score = -1

      expect(hard_ai.minimax(board, :max, players)).to eql(loss_score)
    end

    it "returns the correct score for a pre-draw board" do
      board = TestBoardGenerator.generate([x,   x, o,
                                           o, nil, x,
                                           x,   o, x])
      draw_score = 0

      expect(hard_ai.minimax(board, :max, players)).to eql(draw_score)
    end
  end


  describe '#generate_board' do
    it "returns a board based on a token, a space, and an existing board" do
      token, space = o, 3
      board = TestBoardGenerator.generate([  x, nil, nil,
                                           nil,   o, nil,
                                             x, nil, nil])

      new_board = hard_ai.generate_board(token, space, board)
      expect(new_board.space(space)).to eql(token)
    end
  end


  describe '#score' do
    it "returns the correct score when HardAI has won" do
      board = TestBoardGenerator.generate([  o, nil, nil,
                                           nil,   o, nil,
                                           nil, nil,   o])
      win_score = 1

      expect(hard_ai.score(board, players)).to eql(win_score)
    end

    it "returns the correct score when no one has won" do
      board = TestBoardGenerator.generate([o, o, x,
                                           x, x, o,
                                           o, x, o])
      draw_score = 0

      expect(hard_ai.score(board, players)).to eql(draw_score)
    end

    it "returns the correct score when the opponent has won" do
      board = TestBoardGenerator.generate([  x, nil, nil,
                                           nil,   x, nil,
                                           nil, nil,   x])
      loss_score = -1

      expect(hard_ai.score(board, players)).to eql(loss_score)
    end
  end
end
