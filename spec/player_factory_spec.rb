require 'spec_helper'
require 'tic_tac_toe/player_factory'

describe TicTacToe::PlayerFactory do
  let(:factory) { TicTacToe::PlayerFactory }


  describe '#generate_human_player' do
    it "returns a player with the correct token and decider" do
      token, taken_tokens = :X, []
      human_player = factory.generate_human_player(token, taken_tokens)
      expect(human_player.decider).to eql(TicTacToe::CommandLineIO)
      expect(human_player.token).to equal(:X)
    end
  end


  describe '#generate_computer_player' do
    it "doesn't accept invalid difficulties" do
      token, taken_tokens = :O, []
      invalid_difficulty = :green
      expect { factory.generate_computer_player(token, taken_tokens, invalid_difficulty) }.to raise_error(TicTacToe::InvalidDifficulty)
    end

    it "returns a player with the correct token and decider when given a valid difficulty" do
      token, taken_tokens = :O, []
      difficulty = :medium
      computer_player = factory.generate_computer_player(token, taken_tokens, difficulty)
      expect(computer_player.decider).to eql(TicTacToe::MediumAI)
      expect(computer_player.token).to equal(:O)
    end
  end
end
