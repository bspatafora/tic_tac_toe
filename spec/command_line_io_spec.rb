require 'spec_helper'

describe TicTacToe::CommandLineIO do
  let(:game) { TicTacToe::Game.new }
  let(:io) { TicTacToe::CommandLineIO.new(game) }

  describe '#send_move' do
    
  end

  describe '#solicit_move' do
    it "asks for a stringified move solicitation message" do
      expect(TicTacToe::Stringifier).to receive(:stringify_solicit_move)
      io.solicit_move
    end
  end

  describe '#say_invalid_move' do
    it "asks for a stringified invalid move message" do
      expect(TicTacToe::Stringifier).to receive(:stringify_invalid_move)
      io.say_invalid_move
    end
  end

  describe '#draw_board' do
    it "asks for a stringified representation of its game's board" do
      expect(TicTacToe::Stringifier).to receive(:stringify_board).with(game.board)
      io.draw_board
    end
  end
end
