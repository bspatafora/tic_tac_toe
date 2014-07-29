require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/player'

describe TicTacToes::Core::Player do
  let(:board)          { TicTacToes::Core::Board.new(row_size: 3) }

  let(:io)             { double(invalid_move_error: true) }

  let(:move_strategy)  { double }
  let(:x)              { TicTacToes::Core::Player.new(move_strategy, 'x', false, io) }
  let(:o)              { double }
  let(:players)        { [x, o] }

  let(:history)        { double(record_board_size: true) }

  let(:game_state)     { TicTacToes::Core::GameState.new(board, players, history) }

  describe '#place_and_return_move' do
    it 'only places/returns a move once it receives a valid move' do
      invalid_space, valid_space = 9, 0
      allow(move_strategy).to receive(:move).and_return(invalid_space, valid_space)

      x.place_and_return_move(game_state)
      expect(board.space(valid_space)).to eq(x)
    end

    it 'displays an invalid move error when given an invalid move' do
      invalid_space, valid_space = 9, 0
      allow(move_strategy).to receive(:move).and_return(invalid_space, valid_space)

      expect(io).to receive(:invalid_move_error)
      x.place_and_return_move(game_state)
    end
  end
end
