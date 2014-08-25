module TicTacToes
  module Core
    module MoveStrategies
      class Human
        def initialize(io)
          @io = io
        end

        def type
          MoveStrategies::HUMAN
        end

        def move(game_state)
          @io.move_solicitation

          Integer(@io.solicit_input)
          rescue ArgumentError
            @io.not_an_integer_error
            move(game_state)
        end
      end
    end
  end
end
