require 'tic_tac_toes/test_board_generator'
require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/move_strategies/easy_ai'
require 'tic_tac_toes/core/player_factory'

describe TicTacToes::Core::MoveStrategies::EasyAI do
  describe '#move' do
    it "returns a randomly-selected valid move" do
      player_factory = TicTacToes::Core::PlayerFactory.new('unused_io')
      x = player_factory.generate_human_player('x')
      o = player_factory.generate_computer_player('o', :hard)
      players = [x, o]

      board = TicTacToes::TestBoardGenerator.generate([  o, nil, nil,
                                                       nil,   x, nil,
                                                       nil,   x, nil])

      history = double(record_board_size: true)
      game_state = TicTacToes::Core::GameState.new(board, players, history)
      valid_moves = [1, 2, 3, 5, 6, 8]

      move = TicTacToes::Core::MoveStrategies::EasyAI.move(game_state)
      expect(valid_moves).to include(move)
    end
  end
end
