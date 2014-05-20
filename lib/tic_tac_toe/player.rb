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
      if Rules.token_valid?(token, taken_tokens)
        token
      else
        raise InvalidToken
      end
    end
  end
end
