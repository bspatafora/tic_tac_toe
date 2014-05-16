module TicTacToe
  module AI
    def self.make_move(board, players)
      own_token = players.first.token
      possible_moves = Hash[generate_moves(board).map { |move| [move, nil] }]
      possible_moves.each do |move, score|
        minimax_score = minimax(generate_board(move, own_token, board), :min, players)
        possible_moves[move] = minimax_score
      end
      possible_moves.each { |move, score| return move if score == possible_moves.values.max }
    end

    def self.minimax(board, current_player, players)
      own_token, opponent_token = players.first.token, players.last.token
      return score(board, players) if Rules.game_over?(players, board)
      if current_player == :max
        best_score = -1
        generate_moves(board).each do |move|
          score = minimax(generate_board(move, own_token, board), :min, players)
          best_score = [best_score, score].max
        end
        return best_score
      elsif current_player == :min
        best_score = 1
        generate_moves(board).each do |move|
          score = minimax(generate_board(move, opponent_token, board), :max, players)
          best_score = [best_score, score].min
        end
        return best_score
      end
    end

    def self.generate_board(move, token, board)
      new_board = Marshal::load(Marshal::dump(board))
      new_board.place(move, token)
      new_board
    end

    def self.generate_moves(board)
      possible_moves = Array.new
      board.get_spaces.each_with_index do |space, index|
        possible_moves << index if space.nil?
      end
      possible_moves
    end

    def self.score(board, players)
      own_token, opponent_token = players.first.token, players.last.token
      case Rules.determine_winner(players, board)
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
