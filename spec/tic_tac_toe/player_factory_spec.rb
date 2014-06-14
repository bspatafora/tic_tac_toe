require 'command_line/io'
require 'tic_tac_toe/io_interface'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/spec_helper'

describe TicTacToe::PlayerFactory do
  let(:io) { CommandLine::IO }
  let(:io_interface) { TicTacToe::IOInterface.new(io) }
  let(:player_factory) { TicTacToe::PlayerFactory.new(io_interface) }


  describe '#generate_human_player' do
    it "returns a player with the correct token and decider" do
      token = "X"

      human_player = player_factory.generate_human_player(token)
      expect(human_player.decider).to be_a TicTacToe::IOInterface
      expect(human_player.token).to eq(token)
    end
  end


  describe '#generate_computer_player' do
    it "returns a player with the correct token and decider when given a valid difficulty" do
      token = "O"
      difficulty = :medium

      computer_player = player_factory.generate_computer_player(token, difficulty)
      expect(computer_player.decider).to eql(TicTacToe::MediumAI)
      expect(computer_player.token).to eq(token)
    end
  end
end
