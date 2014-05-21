require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/exceptions'

require 'tic_tac_toe/easy_ai'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/hard_ai'
require 'tic_tac_toe/player'

module TicTacToe
  module PlayerFactory
    def self.generate_computer(difficulty, taken_tokens)
      case difficulty
      when :easy
        generate_player(:computer, EasyAI, taken_tokens)
      when :medium
        generate_player(:computer, MediumAI, taken_tokens)
      when :hard
        generate_player(:computer, HardAI, taken_tokens)
      end
    end

    def self.generate_player(player_type, decider, taken_tokens)
      begin
        token = CommandLineIO.get_token(player_type)
        Player.new(decider, token, taken_tokens)
      rescue InvalidToken
        generate_player(player_type, decider, taken_tokens)
      end
    end
  end
end
