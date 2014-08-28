require 'tic_tac_toes/database/pg_wrapper'
require 'pg'

describe TicTacToes::Database::PGWrapper do
  before do
    @connection = PG.connect(dbname: ENV['TTT_TEST_DATABASE'],
                             host: ENV['TTT_HOST'],
                             port: ENV['TTT_PORT'],
                             user: ENV['TTT_USER'],
                             password: ENV['TTT_PASSWORD'])
    @pg_wrapper = TicTacToes::Database::PGWrapper.new(@connection)
    @history1 = double('history1',
                       board_size: 9,
                       difficulty: 'Medium AI',
                       moves: [['X', 1], ['O', 4]],
                       winner: 'X')
    @history2 = double('history2',
                       board_size: 16,
                       difficulty: 'Easy AI',
                       moves: [['&', 14]],
                       winner: '*')

    @connection.exec("CREATE TABLE games (
      id serial primary key,
      board_size integer,
      difficulty varchar,
      winner varchar)")
    @connection.exec("CREATE TABLE moves (
      game integer REFERENCES games (id),
      number integer,
      token varchar,
      space integer)")
  end

  describe '#record_game_history and #read_games' do
    it 'records and reads a history object to and from the database' do
      @pg_wrapper.record_game_history(@history1)

      history_from_database = @pg_wrapper.read_game_histories.first

      expect(history_from_database.board_size).to eq(9)
      expect(history_from_database.difficulty).to eq('Medium AI')
      expect(history_from_database.moves[0]).to eq(["X", 1])
      expect(history_from_database.moves[1]).to eq(["O", 4])
      expect(history_from_database.winner).to eq("X")
    end

    it 'records and reads multiple history objects to and from the database' do
      @pg_wrapper.record_game_history(@history1)
      @pg_wrapper.record_game_history(@history2)
      histories_from_database = @pg_wrapper.read_game_histories
      expect(histories_from_database.size).to eq(2)
    end
  end

  after do
    @connection.exec("DROP TABLE moves")
    @connection.exec("DROP TABLE games")
  end
end
