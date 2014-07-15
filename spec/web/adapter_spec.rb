require 'web/adapter'

describe Web::Adapter do
  describe '#new_game_state_json' do
    it 'returns a JSON game state object' do
      game_state_json = "{\"spaces\":[null,null,null,null,null,null,null,null,null],\"tokens\":[\"X\",\"O\"]}"
      expect(Web::Adapter.new_game_state_json).to eq(game_state_json)
    end
  end
end
