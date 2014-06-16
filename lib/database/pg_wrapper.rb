require 'pg'
require 'tic_tac_toes/history'

module Database
  class PGWrapper
    def initialize(database)
      @database = database
    end

    def record_game_history(history)
      connection = establish_connection
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

        history = TicTacToes::History.new(self)

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
      PG.connect(dbname: @database)
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
