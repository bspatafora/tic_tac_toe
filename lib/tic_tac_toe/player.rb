require 'tic_tac_toe/exceptions'

module TicTacToe
  class Player
    attr_reader :decider, :token

    def initialize(decider, token, taken_tokens)
      @decider = decider
      @token = validate_token(token, taken_tokens)
    end

    def make_move(board, players)
      begin
        move = @decider.make_move(board, players)
        board.place(move, @token)
      rescue InvalidMove
        make_move(board, players)
      end
    end

    private

    def validate_token(token, taken_tokens)
      if token_valid?(token, taken_tokens)
        token
      else
        raise InvalidToken
      end
    end

    def token_valid?(token, taken_tokens)
      correct_length = token.length == 1
      untaken = !taken_tokens.include?(token)
      correct_length && untaken
    end
  end
end
