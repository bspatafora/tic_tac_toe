require 'tic_tac_toes/core/rules'

module TicTacToes
  module Core
    module MoveStrategies
      module HardAI
        def self.move(game_state)
          board = game_state.board

          return 0 if nine_board_first_move?(board)
          return second_move(board) if nine_board_second_move?(board)

          open_spaces = Hash[board.open_spaces.map { |space| [space, nil] }]

          open_spaces.each do |space, score|
            score = minimax(generate_board(game_state.current_player, space, board), :min, game_state.players)
            open_spaces[space] = score
          end

          best_score = open_spaces.values.max
          open_spaces.each { |space, score| return space if score == best_score }
        end

        private

        def self.minimax(board, current_player, players)
          return score(board, players) if Rules.game_over?(board, players)

          if current_player == :max
            best_score = -1
            board.open_spaces.each do |space|
              score = minimax(generate_board(players.first, space, board), :min, players)
              best_score = [best_score, score].max
            end
            best_score

          elsif current_player == :min
            best_score = 1
            board.open_spaces.each do |space|
              score = minimax(generate_board(players.last, space, board), :max, players)
              best_score = [best_score, score].min
            end
            best_score
          end
        end

        def self.generate_board(player, space, board)
          new_board = Marshal.load(Marshal.dump(board))
          new_board.place(player, space)
          new_board
        end

        def self.score(board, players)
          own_token, opponent_token = players.first.token, players.last.token

          case Rules.determine_winner(board, players)
          when own_token
            1
          when opponent_token
            -1
          else
            0
          end
        end

        def self.nine_board_first_move?(board)
          board.size == 9 && board.open_spaces.count == 9
        end

        def self.nine_board_second_move?(board)
          board.size == 9 && board.open_spaces.count == 8
        end

        def self.second_move(board)
          if nine_board_corner_occupied(board) || nine_board_side_occupied(board)
            4
          elsif nine_board_center_occupied(board)
            0
          end
        end

        def self.nine_board_corner_occupied(board)
          board.space(0) || board.space(2) || board.space(6) || board.space(8)
        end

        def self.nine_board_side_occupied(board)
          board.space(1) || board.space(3) || board.space(5) || board.space(7)
        end

        def self.nine_board_center_occupied(board)
          board.space(4) ? true : false
        end
      end
    end
  end
end
