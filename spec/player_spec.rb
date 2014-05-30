require 'spec_helper'
require 'tic_tac_toe/player'
require 'tic_tac_toe/stringifier'

describe TicTacToe::Player do
  let(:io) { TicTacToe::CommandLineIO }
  let(:board) { TicTacToe::Board.new(row_size: 3) }
  let(:players) { double("players") }

  describe '#make_move' do
    let(:token) { :X }
    needs_to_think = false
    let(:player) { TicTacToe::Player.new(double("decider"), token, needs_to_think) }
 
    it "only returns a move once it receives a valid move" do
      invalid_move, valid_move = 9, 0
      allow(io).to receive(:error_notification)
      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)

      player.make_move(board, players)
      expect(board.space(valid_move)).to eql(token)
    end

    it "sends an error notification with an invalid move message when given an invalid move" do
      invalid_move, valid_move = 9, 0
      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)

      expect(io).to receive(:error_notification).with(TicTacToe::Stringifier.invalid_move)
      player.make_move(board, players)
    end
  end
end
