require 'tic_tac_toes/core/move_strategies/human'
require 'tic_tac_toes/core/move_strategies/medium_ai'
require 'tic_tac_toes/core/player_factory'

describe TicTacToes::Core::PlayerFactory do
  let(:player_factory) { TicTacToes::Core::PlayerFactory.new("io") }

  describe '#generate_human_player' do
    it "returns a player with the correct token and move strategy" do
      strategy = TicTacToes::Core::MoveStrategies::Human
      token = 'X'

      human_player = player_factory.generate_human_player(token)
      expect(human_player.move_strategy).to be_a strategy
      expect(human_player.token).to eq(token)
    end
  end

  describe '#generate_computer_player' do
    it 'returns a player with the correct token and move strategy' do
      token = 'O'
      difficulty = :medium
      strategy = TicTacToes::Core::MoveStrategies::MediumAI

      computer_player = player_factory.generate_computer_player(token,
                                                                difficulty)
      expect(computer_player.move_strategy).to eq(strategy)
      expect(computer_player.token).to eq(token)
    end
  end
end
