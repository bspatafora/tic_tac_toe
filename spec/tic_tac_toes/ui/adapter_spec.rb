require 'tic_tac_toes/core/game_state'
require 'tic_tac_toes/core/player_factory'
require 'tic_tac_toes/test_board_generator'
require 'tic_tac_toes/ui/adapter'

describe TicTacToes::UI::Adapter do
  describe '#make_move' do
    let(:history)    { TicTacToes::UI::NullHistory.new }

    player_factory = TicTacToes::Core::PlayerFactory.new('unused_io')
    let(:x)          { player_factory.generate_human_player('x') }
    let(:o)          { player_factory.generate_computer_player('o', :hard) }
    let(:players)    { [x, o] }

    context 'when the game is still in progress' do
      it 'sends its listener #moves_were_made with the updated game state' do
        board = TicTacToes::TestBoardGenerator.generate([  x, nil, nil,
                                                         nil,   o, nil,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)
        move = '2'
        listener = double

        allow(listener).to receive(:moves_were_made)
        TicTacToes::UI::Adapter.make_move(game_state, move, listener)

        first_move, second_move = 2, 1
        board.place(x, first_move)
        board.place(o, second_move)
        expect(listener).to have_received(:moves_were_made).with(game_state)
      end
    end

    context 'when the game has ended with a winner' do
      it 'sends its listener #game_ended_in_winner with the updated game state and the winning token' do
        board = TicTacToes::TestBoardGenerator.generate([  x,   x, nil,
                                                         nil, nil, nil,
                                                         nil, nil, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)
        move = '2'
        listener = double
        winning_token = 'x'

        allow(listener).to receive(:game_ended_in_winner)
        TicTacToes::UI::Adapter.make_move(game_state, move, listener)

        board.place(x, 2)
        expect(listener).to have_received(:game_ended_in_winner).with(game_state, winning_token)
      end
    end

    context 'when the game has ended in a draw' do
      it 'sends its listener #game_ended_in_draw with the updated game state' do
        board = TicTacToes::TestBoardGenerator.generate([x, x,   o,
                                                         o, o,   x,
                                                         x, o, nil])
        game_state = TicTacToes::Core::GameState.new(board, players, history)
        move = '8'
        listener = double

        allow(listener).to receive(:game_ended_in_draw)
        TicTacToes::UI::Adapter.make_move(game_state, move, listener)

        board.place(x, 8)
        expect(listener).to have_received(:game_ended_in_draw).with(game_state)
      end
    end
  end
end
