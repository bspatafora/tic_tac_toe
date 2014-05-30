require 'tic_tac_toe/player'
require 'tic_tac_toe/rules'

require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/easy_ai'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/hard_ai'

module TicTacToe
  module PlayerFactory
    def self.generate_human_player(token)
      token = CommandLineIO.blue(token)
      needs_to_think = false
      Player.new(CommandLineIO, token, needs_to_think)
    end

    def self.generate_computer_player(token, difficulty)
      token = CommandLineIO.red(token)
      needs_to_think = true
      Player.new(Rules::AI_DIFFICULTIES[difficulty], token, needs_to_think)
    end
  end
end
