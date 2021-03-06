require 'tic_tac_toes/test_board_generator'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/move_strategies/medium_ai'
require 'tic_tac_toes/core/player_factory'

describe TicTacToes::Core::MoveStrategies::MediumAI do
  describe '#type' do
    it 'returns :computer' do
      expect(TicTacToes::Core::MoveStrategies::MediumAI.type).to eq(:computer)
    end
  end

  describe '#ai_type' do
    it "returns 'MEDIUM_AI'" do
      expect(TicTacToes::Core::MoveStrategies::MediumAI.ai_type).to eq('MEDIUM_AI')
    end
  end

  describe '#move' do
    it "returns a valid move (based on either EasyAI or HardAI)" do
      player_factory = TicTacToes::Core::PlayerFactory.new('unused_io')
      x = player_factory.generate_player('x', TicTacToes::Core::PlayerFactory::HUMAN)
      o = player_factory.generate_player('o', TicTacToes::Core::PlayerFactory::MEDIUM_AI)
      players = [x, o]

      board = TicTacToes::TestBoardGenerator.generate([  o,  o,   x,
                                                       nil,  x, nil,
                                                       nil,  x, nil])

      history = TicTacToes::UI::NullHistory.new
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      valid_moves = [3, 5, 6, 8]

      move = TicTacToes::Core::MoveStrategies::MediumAI.move(game_state)
      expect(valid_moves).to include(move)
    end
  end
end
