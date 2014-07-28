require 'tic_tac_toes/test_board_generator'
require 'tic_tac_toes/core/move_strategies/easy_ai'

describe TicTacToes::Core::MoveStrategies::EasyAI do
  describe '#move' do
    let(:players) { double("players") }
    let(:easy_ai) { TicTacToes::Core::MoveStrategies::EasyAI }

    it "returns a randomly-selected valid move" do
      board = TicTacToes::TestBoardGenerator.generate([ :O, nil, nil,
                                                       nil,  :X, nil,
                                                       nil,  :X, nil])
      valid_moves = [1, 2, 3, 5, 6, 8]

      move = easy_ai.move(board, players)
      expect(valid_moves).to include(move)
    end
  end
end
