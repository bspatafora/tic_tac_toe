require 'pg'

module Database
  class PGWrapper
    def initialize(database)
      @database = database
    end

    def record_game(history)
      connection = PG.connect(dbname: @database)
      connection.exec("CREATE TABLE IF NOT EXISTS history (board_size integer, moves text, winner char(1))")
      moves_string = parse_for_database(history.moves)

      connection.exec("INSERT INTO history VALUES (
        #{history.board_size}, '#{moves_string}', '#{history.winner}')")
    end

    def parse_for_database(moves)
      moves_string = ""

      moves.each do |move|
        moves_string << move.first.to_s
        moves_string << move.last.to_s
      end

      moves_string
    end
  end
end
