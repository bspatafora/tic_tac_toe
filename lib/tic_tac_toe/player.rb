require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/stringifier'

module TicTacToe
  class Player
    attr_reader :decider, :token, :needs_to_think

    def initialize(decider, token, needs_to_think, io: CommandLineIO)
      @decider = decider
      @token = token
      @needs_to_think = needs_to_think
      @io = io
    end

    def make_move(board, players)
      loop do
        space = @decider.make_move(board, players)
        break if board.place(@token, space)
        @io.red_notification(Stringifier.invalid_move)
      end
    end
  end
end
