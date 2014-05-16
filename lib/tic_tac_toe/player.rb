require 'tic_tac_toe/exceptions'

module TicTacToe
  class Player
    attr_reader :decider, :token

    def initialize(decider, token)
      @decider = decider
      @token = token
    end

    def make_move(board, players)
      begin
        move = @decider.make_move(board, players)
        board.place(move, @token)
      rescue InvalidMove
        make_move(board, players)
      end
    end
  end
end
