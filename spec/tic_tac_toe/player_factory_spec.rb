require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/command_line/io'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/player_factory'

describe TicTacToe::PlayerFactory do
  let(:io) { TicTacToe::IO }
  let(:player_factory) { TicTacToe::PlayerFactory.new(io) }


  describe '#generate_human_player' do
    it "returns a player with the correct token (colored blue) and decider" do
      token = "X"
      colored_token = io.blue(token)

      human_player = player_factory.generate_human_player(token)
      expect(human_player.decider).to eql(io)
      expect(human_player.token).to eq(colored_token)
    end
  end


  describe '#generate_computer_player' do
    it "returns a player with the correct token (colored red) and decider when given a valid difficulty" do
      token = "O"
      colored_token = io.red(token)
      difficulty = :medium

      computer_player = player_factory.generate_computer_player(token, difficulty)
      expect(computer_player.decider).to eql(TicTacToe::MediumAI)
      expect(computer_player.token).to eq(colored_token)
    end
  end
end
