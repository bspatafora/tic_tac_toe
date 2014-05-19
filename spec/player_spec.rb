require 'spec_helper'
require 'tic_tac_toe/player'
require 'tic_tac_toe/exceptions'

describe TicTacToe::Player do
  describe '#initialize' do
    it "doesn't accept non-single character tokens" do
      decider = double("test decider")
      invalid_token = :invalid
      taken_tokens = []
      expect{ TicTacToe::Player.new(decider, invalid_token, taken_tokens) }.to raise_error(TicTacToe::InvalidToken)
    end

    it "doesn't accept already-taken tokens" do
      decider = double("test decider")
      invalid_token = :X
      taken_tokens = [:X]
      expect{ TicTacToe::Player.new(decider, invalid_token, taken_tokens) }.to raise_error(TicTacToe::InvalidToken)
    end

    it "accepts valid tokens" do
      valid_token = :X
      taken_tokens = []
      player = TicTacToe::Player.new(double("test decider"), valid_token, taken_tokens)
      expect(player.token).to eql(:X)
    end
  end


  describe '#make_move' do
    taken_tokens = []
    let(:player) { TicTacToe::Player.new(double("test decider"), :X, taken_tokens) }
    let(:board) { TicTacToe::Board.new }
    let(:players) { double("players") }

    it "asks until it receives a valid move" do
      invalid_move, valid_move = 100, 0
      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)
      player.make_move(board, players)
      expect(board.get_space(0)).to eql(:X)
    end
  end
end
