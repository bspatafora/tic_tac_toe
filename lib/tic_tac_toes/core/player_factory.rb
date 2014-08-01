require 'tic_tac_toes/core/move_strategies/human'
require 'tic_tac_toes/core/move_strategies/easy_ai'
require 'tic_tac_toes/core/move_strategies/medium_ai'
require 'tic_tac_toes/core/move_strategies/hard_ai'
require 'tic_tac_toes/core/player'

module TicTacToes
  module Core
    class PlayerFactory

      HUMAN = :human
      EASY_AI = :easy
      MEDIUM_AI = :medium
      HARD_AI = :hard

      AIS = {
        EASY_AI => MoveStrategies::EasyAI,
        MEDIUM_AI => MoveStrategies::MediumAI,
        HARD_AI => MoveStrategies::HardAI
      }

      def initialize(io)
        @io = io
      end

      def generate_player(token, type)
        case type
        when HUMAN
          Player.new(MoveStrategies::Human.new(@io), token, false, @io)
        else
          Player.new(AIS[type], token, true, @io)
        end
      end
    end
  end
end
