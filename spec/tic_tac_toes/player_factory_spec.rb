require 'command_line/io'
require 'tic_tac_toes/io_interface'
require 'tic_tac_toes/medium_ai'
require 'tic_tac_toes/player_factory'
require 'tic_tac_toes/spec_helper'

describe TicTacToes::PlayerFactory do
  let(:io) { CommandLine::IO }
  let(:io_interface) { TicTacToes::IOInterface.new(io) }
  let(:player_factory) { TicTacToes::PlayerFactory.new(io_interface) }


  describe '#generate_human_player' do
    it "returns a player with the correct token and decider" do
      token = "X"

      human_player = player_factory.generate_human_player(token)
      expect(human_player.decider).to be_a TicTacToes::IOInterface
      expect(human_player.token).to eq(token)
    end
  end


  describe '#generate_computer_player' do
    it "returns a player with the correct token and decider when given a valid difficulty" do
      token = "O"
      difficulty = :medium

      computer_player = player_factory.generate_computer_player(token, difficulty)
      expect(computer_player.decider).to eql(TicTacToes::MediumAI)
      expect(computer_player.token).to eq(token)
    end
  end
end
