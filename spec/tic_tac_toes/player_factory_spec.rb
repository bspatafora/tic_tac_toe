require 'tic_tac_toes/move_strategies/human'
require 'tic_tac_toes/move_strategies/medium_ai'
require 'tic_tac_toes/player_factory'

describe TicTacToes::PlayerFactory do
  let(:player_factory) { TicTacToes::PlayerFactory.new("io") }


  describe '#generate_human_player' do
    it "returns a player with the correct token and move_strategy" do
      token = "X"

      human_player = player_factory.generate_human_player(token)
      expect(human_player.move_strategy).to be_a TicTacToes::MoveStrategies::Human
      expect(human_player.token).to eq(token)
    end
  end


  describe '#generate_computer_player' do
    it "returns a player with the correct token and move_strategy when given a valid difficulty" do
      token = "O"
      difficulty = :medium

      computer_player = player_factory.generate_computer_player(token, difficulty)
      expect(computer_player.move_strategy).to eq(TicTacToes::MoveStrategies::MediumAI)
      expect(computer_player.token).to eq(token)
    end
  end
end
