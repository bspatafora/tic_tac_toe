require 'database/pg_wrapper'
require 'pg'
require 'tic_tac_toe/history'
require 'tic_tac_toe/spec_helper'

describe Database::PGWrapper do
  database = "test"
  let(:pg_wrapper) { Database::PGWrapper.new(database) }

  before do
    @history1 = TicTacToe::History.new
    @history1.record_board_size(9)
    @history1.record_move(["X", 1])
    @history1.record_move(["O", 4])
    @history1.record_winner("X")

    @history2 = TicTacToe::History.new
    @history2.record_board_size(16)
    @history2.record_move(["&", 14])
    @history2.record_winner("*")
  end

  describe '#record_game_history and #read_games' do
    it "records and reads history objects to and from the database" do
      pg_wrapper.record_game_history(@history1)
      pg_wrapper.record_game_history(@history2)

      games = pg_wrapper.read_game_histories
      history1 = games[0]
      history2 = games[1]

      expect(history1.board_size).to eq(9)
      expect(history1.moves[0]).to eq(["X", 1])
      expect(history1.moves[1]).to eq(["O", 4])
      expect(history1.winner).to eq("X")

      expect(history2.board_size).to eq(16)
      expect(history2.moves[0]).to eq(["&", 14])
      expect(history2.winner).to eq("*")
    end

    it "writes the winner to the database" do
      connection = PG.connect(dbname: database)
      pg_wrapper.record_game_history(@history1)
      rows = connection.exec("SELECT * FROM games")
      winner = rows.first["winner"]
      expect(winner).to eq ("X")
    end
  end

  after do
    connection = PG.connect(dbname: database)
    connection.exec("DROP TABLE moves")
    connection.exec("DROP TABLE games")
  end
end
