require 'tic_tac_toe/easy_ai'
require 'tic_tac_toe/hard_ai'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/player'

module TicTacToe
  class PlayerFactory
    AI_DIFFICULTIES = { easy: EasyAI, medium: MediumAI, hard: HardAI }

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
      Player.new(AI_DIFFICULTIES[difficulty], token, needs_to_think, @io)
    end
  end
end
