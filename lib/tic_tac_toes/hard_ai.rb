require 'tic_tac_toes/rules'

module TicTacToes
  module HardAI
    def self.make_move(board, players)
      open_spaces = Hash[board.open_spaces.map { |space| [space, nil] }]

      open_spaces.each do |space, score|
        score = minimax(generate_board(players.first, space, board), :min, players)
        open_spaces[space] = score
      end

      best_score = open_spaces.values.max
      open_spaces.each { |space, score| return space if score == best_score }
    end

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
  end
end
