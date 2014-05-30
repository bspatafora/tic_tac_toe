require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/player'
require 'tic_tac_toe/stringifier'

describe TicTacToe::Player do
  let(:io) { TicTacToe::CommandLineIO }
  let(:stringifier) { TicTacToe::Stringifier }
  let(:board) { TicTacToe::Board.new(row_size: 3) }
  let(:players) { double("players") }

  describe '#make_move' do
    let(:decider) { double("decider") }
    let(:token) { :X }
    let(:needs_to_think) { false }

    let(:player) { TicTacToe::Player.new(decider, token, needs_to_think) }
 
    it "only returns a move once it receives a valid move" do
      invalid_move, valid_move = 9, 0
      allow(io).to receive(:red_notification)
      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)

      player.make_move(board, players)
      expect(board.space(valid_move)).to eql(token)
    end

    it "sends a red notification with an invalid move message when given an invalid move" do
      invalid_move, valid_move = 9, 0
      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)

      expect(io).to receive(:red_notification).with(stringifier.invalid_move)
      player.make_move(board, players)
    end
  end
end
