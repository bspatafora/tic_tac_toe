require 'tic_tac_toes/core/history'
require 'tic_tac_toes/core/move_strategies/medium_ai'

describe TicTacToes::Core::History do
  let(:database_wrapper)  { double("database wrapper", :record_game_history => true) }
  let(:history)           { TicTacToes::Core::History.new(database_wrapper) }

  describe '#record_board_size' do
    it "records the passed board size" do
      board_size = 9

      history.record_board_size(board_size)
      expect(history.board_size).to eq(board_size)
    end
  end

  describe '#record_difficulty' do
    it "records the passed difficulty" do
      difficulty = TicTacToes::Core::MoveStrategies::MediumAI

      history.record_difficulty(difficulty)
      expect(history.difficulty).to eq('Medium AI')
    end
  end

  describe '#record_move' do
    it "records the passed token and space" do
      move = ["X", 0]

      history.record_move(move)
      expect(history.moves.first).to eq(move)
    end

    it "doesn’t record anything if move is nil" do
      move = nil

      history.record_move(move)
      expect(history.moves).to eq([])
    end
  end

  describe '#record_winner' do
    it "records the token of the passed winner" do
      winner = double(token: 'O')

      history.record_winner(winner)
      expect(history.winner).to eq(winner.token)
    end
  end

  describe '#persist' do
    it "sends the history instance to its database interface for storage" do
      expect(database_wrapper).to receive(:record_game_history).with history
      history.persist
    end
  end
end
