require 'tic_tac_toes/move_strategies/easy_ai'
require 'tic_tac_toes/move_strategies/medium_ai'
require 'tic_tac_toes/move_strategies/hard_ai'
require 'tic_tac_toes/move_strategies/human'
require 'tic_tac_toes/player'

module TicTacToes
  class PlayerFactory
    AI_DIFFICULTIES = { easy: ::TicTacToes::MoveStrategies::EasyAI, medium: ::TicTacToes::MoveStrategies::MediumAI, hard: ::TicTacToes::MoveStrategies::HardAI }

    def initialize(io)
      @io = io
    end

    def generate_human_player(token)
      needs_to_think = false
      Player.new(::TicTacToes::MoveStrategies::Human.new(@io), token, needs_to_think, @io)
    end

    def generate_computer_player(token, difficulty)
      needs_to_think = true
      Player.new(AI_DIFFICULTIES[difficulty], token, needs_to_think, @io)
    end
  end
end
