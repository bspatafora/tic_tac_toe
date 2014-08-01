require 'tic_tac_toes/core/move_strategies/human'
require 'tic_tac_toes/core/move_strategies/medium_ai'
require 'tic_tac_toes/core/player_factory'

describe TicTacToes::Core::PlayerFactory do
  describe '#generate_player' do
    before { @player_factory = TicTacToes::Core::PlayerFactory.new('io') }

    context 'when passed HUMAN' do
      it "returns a player with the correct token and a Human move strategy" do
        human_player = @player_factory.generate_player('X', TicTacToes::Core::PlayerFactory::HUMAN)

        expect(human_player.token).to eq('X')
        expect(human_player.move_strategy).to be_a TicTacToes::Core::MoveStrategies::Human
      end
    end

    context 'when passed EASY_AI, MEDIUM_AI, or HARD_AI' do
      it 'returns a player with the correct token and correct AI move strategy' do
        computer_player = @player_factory.generate_player('O', TicTacToes::Core::PlayerFactory::MEDIUM_AI)

        expect(computer_player.move_strategy).to eq(TicTacToes::Core::MoveStrategies::MediumAI)
        expect(computer_player.token).to eq('O')
      end
    end
  end
end
