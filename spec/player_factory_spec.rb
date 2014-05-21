require 'spec_helper'
require 'tic_tac_toe/player_factory'

describe TicTacToe::PlayerFactory do
  let(:factory) { TicTacToe::PlayerFactory }
  let(:io) { TicTacToe::CommandLineIO }

  describe '#generate_computer' do
    it "generates a player based on a difficulty" do
      difficulty = :easy
      taken_tokens = []
      expect(factory).to receive(:generate_player).with(:computer, TicTacToe::EasyAI, taken_tokens)
      factory.generate_computer(difficulty, taken_tokens)
    end
  end


  describe '#generate_player' do
    let(:taken_tokens) { [:X] }
    let(:player) { factory.generate_player(double("player type"), double("decider"), taken_tokens) }

    it "asks until it receives a valid token" do
      invalid_token, valid_token = taken_tokens.first, :O
      allow(io).to receive(:get_token).and_return(invalid_token, valid_token)
      expect(player.token).to eql(:O)
    end
  end
end
