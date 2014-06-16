require 'tic_tac_toes/easy_ai'
require 'tic_tac_toes/hard_ai'
require 'tic_tac_toes/medium_ai'
require 'tic_tac_toes/player'

module TicTacToes
  class PlayerFactory
    AI_DIFFICULTIES = { easy: EasyAI, medium: MediumAI, hard: HardAI }

    def initialize(io_interface)
      @io_interface = io_interface
    end

    def generate_human_player(token)
      needs_to_think = false
      Player.new(@io_interface, token, needs_to_think, @io_interface)
    end

    def generate_computer_player(token, difficulty)
      needs_to_think = true
      Player.new(AI_DIFFICULTIES[difficulty], token, needs_to_think, @io_interface)
    end
  end
end
