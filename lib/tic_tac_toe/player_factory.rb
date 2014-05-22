require 'tic_tac_toe/exceptions'
require 'tic_tac_toe/player'

require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/easy_ai'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/hard_ai'

module TicTacToe
  module PlayerFactory
    def self.generate_human_player(token, taken_tokens)
      Player.new(CommandLineIO, token, taken_tokens)
    end

    def self.generate_computer_player(token, taken_tokens, difficulty)
      case difficulty
      when :easy
        Player.new(EasyAI, token, taken_tokens)
      when :medium
        Player.new(MediumAI, token, taken_tokens)
      when :hard
        Player.new(HardAI, token, taken_tokens)
      else
        raise InvalidDifficulty
      end
    end
  end
end
