require 'pg'

module Database
  class PGWrapper
    def initialize(database)
      @database = database
    end

    def record_game(history)
      connection = establish_connection
      create_tables_if_needed(connection)
      record_board_size_and_winner(history, connection)
      record_moves(history, connection)
    end

    private

    def establish_connection
      PG.connect(dbname: @database)
    end

    def create_tables_if_needed(connection)
      connection.exec("CREATE TABLE IF NOT EXISTS games (
        id serial primary key,
        board_size integer,
        winner char(1))")
      connection.exec("CREATE TABLE IF NOT EXISTS moves (
        game integer REFERENCES games (id),
        number integer,
        token char(1),
        space integer)")
    end

    def record_board_size_and_winner(history, connection)
      connection.exec("INSERT INTO games (board_size, winner) VALUES (
        #{history.board_size},
        '#{history.winner}')")
    end

    def record_moves(history, connection)
      game_id = get_game_id(connection)

      history.moves.each_with_index do |move, index|
        move_number = index + 1
        connection.exec("INSERT INTO moves (game, number, token, space) VALUES (
          #{game_id},
          #{move_number},
          '#{move.first}',
          #{move.last})")
      end
    end

    def get_game_id(connection)
      result = connection.exec("SELECT currval(pg_get_serial_sequence('games','id'))")
      result.getvalue(0,0)
    end
  end
end
