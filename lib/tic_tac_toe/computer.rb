module TicTacToe
  class Computer
    attr_reader :human_token, :computer_token

    def initialize(game)
      @game = game
      @human_token = game.tokens.first
      @computer_token = game.tokens.last
    end

    def make_move(board)
      possible_moves = Hash[generate_moves(board).map { |move| [move, nil] }]
      possible_moves.each do |move, score|
        possible_moves[move] = minimax(generate_board(move, @computer_token, board), @human_token)
      end
      possible_moves.each do |move, score|
        return move if score == possible_moves.values.max
      end
    end

    def minimax(board, player)
      return score(board) if Rules.game_over?(@game.tokens, board)
      if player == @computer_token
        best_score = -1
        generate_moves(board).each do |move|
          score = minimax(generate_board(move, @computer_token, board), @human_token)
          best_score = [best_score, score].max
        end
        return best_score
      else
        best_score = 1
        generate_moves(board).each do |move|
          score = minimax(generate_board(move, @human_token, board), @computer_token)
          best_score = [best_score, score].min
        end
        return best_score
      end
    end

    def generate_board(move, token, board)
      new_board = Marshal::load(Marshal::dump(board))
      new_board.place(move, token)
      new_board
    end

    def generate_moves(board)
      possible_moves = Array.new
      board.spaces.each_with_index do |space, index|
        possible_moves << index if space.nil?
      end
      possible_moves
    end

    def score(board)
      tokens = @game.tokens
      case Rules.determine_winner(tokens, board)
      when @computer_token
        1
      when nil
        0
      else
        -1
      end
    end
  end
end
