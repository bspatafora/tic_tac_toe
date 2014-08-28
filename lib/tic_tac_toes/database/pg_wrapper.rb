require 'pg'
require 'tic_tac_toes/core/history'

module TicTacToes
  module Database
    class PGWrapper
      def initialize(connection)
        @connection = connection
      end

      def record_game_history(history)
        record_game_info(history, @connection)
        record_moves(history, @connection)
      end

      def read_game_histories
        games_result = @connection.exec("SELECT * FROM games")
        games = []

        games_result.each_row do |row|
          game_id = row[0]
          board_size = row[1].to_i
          difficulty = row[2]
          winner = row[3]
          moves_result = @connection.exec("SELECT * FROM moves WHERE game = #{game_id}")

          history = Core::History.new(self)

          moves_result.each_row do |row|
            token, space = row[2], row[3].to_i
            history.record_move([token, space])
          end
          history.record_board_size(board_size)
          history.record_difficulty(difficulty)
          history.record_winner(winner)

          games << history
        end

        games
      end

      private

      def record_game_info(history, connection)
        connection.exec("INSERT INTO games (board_size, difficulty, winner) VALUES (
          #{history.board_size},
          '#{history.difficulty}',
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
end
