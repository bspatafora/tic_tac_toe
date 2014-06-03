require 'tic_tac_toe/player'
require 'tic_tac_toe/rules'

module TicTacToe
  class PlayerFactory
    def initialize(io)
      @io = io
    end

    def generate_human_player(token)
      token = @io.blue(token)
      needs_to_think = false
      Player.new(@io, token, needs_to_think, @io)
    end

    def generate_computer_player(token, difficulty)
      token = @io.red(token)
      needs_to_think = true
      Player.new(Rules::AI_DIFFICULTIES[difficulty], token, needs_to_think, @io)
    end
  end
end
