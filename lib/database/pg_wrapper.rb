require 'pg'

module Database
  class PGWrapper
    def initialize(database)
      @database = database
    end

    def record_game(history)
      connection = PG.connect(dbname: @database)
      create_tables_if_needed(connection)

      connection.exec("INSERT INTO games (board_size, winner) VALUES (
        #{history.board_size},
        '#{history.winner}')")

      game_id_result = connection.exec("SELECT currval(pg_get_serial_sequence('games','id'))")

      history.moves.each_with_index do |move, index|
        move_number = index + 1
        connection.exec("INSERT INTO moves (game, number, token, space) VALUES (
          #{game_id_result.getvalue(0,0)},
          #{move_number},
          '#{move.first}',
          #{move.last})")
      end
    end

    private

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
  end
end
