require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/stringifier'

module TicTacToe
  class Player
    attr_reader :decider, :token

    def initialize(decider, token, io: CommandLineIO)
      @decider = decider
      @token = token
      @io = io
    end

    def make_move(board, players)
      loop do
        space = @decider.make_move(board, players)
        break if board.place(@token, space)
        @io.error_notification(Stringifier.invalid_move)
      end
    end
  end
end
