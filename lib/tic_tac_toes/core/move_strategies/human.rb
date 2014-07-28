module TicTacToes
  module Core
    module MoveStrategies
      class Human
        def initialize(io)
          @io = io
        end

        def move(board, players)
          @io.move_solicitation

          Integer(@io.solicit_input)
          rescue ArgumentError
            @io.not_an_integer_error
            move(board, players)
        end
      end
    end
  end
end
