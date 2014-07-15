require 'json'

module Web
  module Adapter
    def self.new_game_state_json
      game_state_structure = { spaces: Array.new(9), tokens: ['X', 'O'] }
      JSON.generate(game_state_structure)
    end
  end
end
