require 'tic_tac_toes/core/move_strategies/human'
require 'tic_tac_toes/core/move_strategies/easy_ai'
require 'tic_tac_toes/core/move_strategies/medium_ai'
require 'tic_tac_toes/core/move_strategies/hard_ai'
require 'tic_tac_toes/core/player'

module TicTacToes
  module Core
    class PlayerFactory
      def initialize(io)
        @io = io
      end

      AIS = {
        easy:    ::TicTacToes::Core::MoveStrategies::EasyAI,
        medium:  ::TicTacToes::Core::MoveStrategies::MediumAI,
        hard:    ::TicTacToes::Core::MoveStrategies::HardAI }

      def generate_human_player(token)
        needs_to_think = false
        Player.new(TicTacToes::Core::MoveStrategies::Human.new(@io), token, needs_to_think, @io)
      end

      def generate_computer_player(token, difficulty)
        needs_to_think = true
        Player.new(AIS[difficulty], token, needs_to_think, @io)
      end
    end
  end
end
