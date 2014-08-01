require 'tic_tac_toes/core/board'
require 'tic_tac_toes/core/rules'
require 'tic_tac_toes/core/player_factory'

module TicTacToes
  module CommandLine
    class Menu
      def initialize(io, player_factory)
        @io = io
        @player_factory = player_factory
      end

      def get_board
        TicTacToes::Core::Board.new(row_size: get_row_size)
      end

      def get_players
        taken_tokens = []
        human_token = get_token(:human, taken_tokens)
        taken_tokens << human_token
        computer_token = get_token(:computer, taken_tokens)
        difficulty = get_difficulty

        human_player = @player_factory.generate_player(human_token, Core::PlayerFactory::HUMAN)
        computer_player = @player_factory.generate_player(computer_token, difficulty)
        [human_player, computer_player]
      end

      private

      def get_row_size
        loop do
          row_size = @io.get_row_size
          break row_size if Core::Rules.row_size_valid?(row_size)
          @io.invalid_row_size_error
        end
      end

      def get_token(player, taken_tokens)
        loop do
          token = @io.get_token(player)
          break token if Core::Rules.token_valid?(token, taken_tokens)
          @io.invalid_token_error
        end
      end

      def get_difficulty
        loop do
          difficulty = @io.get_difficulty
          break difficulty if Core::Rules.difficulty_valid?(difficulty)
          @io.invalid_difficulty_error
        end
      end
    end
  end
end
