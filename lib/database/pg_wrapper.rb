require 'pg'
require 'tic_tac_toe/history'

module Database
  class PGWrapper
    def initialize(database)
      @database = database
    end

    def record_game_history(history)
      connection = establish_connection
      create_tables_if_needed(connection)
      record_board_size_and_winner(history, connection)
      record_moves(history, connection)
    end

    def read_game_histories
      connection = establish_connection
      games_result = connection.exec("SELECT * FROM games")
      games = []

      games_result.each_row do |row|
        game_id = row[0]
        board_size = row[1].to_i
        winner = row[2]
        moves_result = connection.exec("SELECT * FROM moves WHERE game = #{game_id}")

        history = TicTacToe::History.new(self)

        moves_result.each_row do |row|
          token, space = row[2], row[3].to_i
          history.record_move([token, space])
        end
        history.record_board_size(board_size)
        history.record_winner(winner)

        games << history
      end

      games
    end

    private

    def establish_connection
      connection = PG.connect(dbname: @database)

      # Suppress PostgreSQL notices that tables already exist
      connection.exec("set client_min_messages=warning")

      connection
    end

    def create_tables_if_needed(connection)
      connection.exec("CREATE TABLE IF NOT EXISTS games (
        id serial primary key,
        board_size integer,
        winner varchar)")
      connection.exec("CREATE TABLE IF NOT EXISTS moves (
        game integer REFERENCES games (id),
        number integer,
        token varchar,
        space integer)")
    end

    def record_board_size_and_winner(history, connection)
      connection.exec("INSERT INTO games (board_size, winner) VALUES (
        #{history.board_size},
        '#{history.winner}')")
    end

    def record_moves(history, connection)
      game_id = read_game_id(connection)

      history.moves.each_with_index do |move, index|
        move_number = index + 1
        connection.exec("INSERT INTO moves (game, number, token, space) VALUES (
          #{game_id},
          #{move_number},
          '#{move.first}',
          #{move.last})")
      end
    end

    def read_game_id(connection)
      result = connection.exec("SELECT currval(pg_get_serial_sequence('games','id'))")
      result.getvalue(0,0)
    end
  end
end
