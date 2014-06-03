require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/command_line/io'
require 'tic_tac_toe/player'
require 'tic_tac_toe/stringifier'

describe TicTacToe::Player do
  let(:io) { TicTacToe::IO }
  let(:stringifier) { TicTacToe::Stringifier }
  let(:board) { TicTacToe::Board.new(row_size: 3) }
  let(:players) { double("players") }

  describe '#make_move' do
    let(:decider) { double("decider") }
    let(:token) { :X }
    let(:needs_to_think) { false }

    let(:player) { TicTacToe::Player.new(decider, token, needs_to_think, io) }
 
    it "only returns a move once it receives a valid move" do
      invalid_move, valid_move = 9, 0
      allow(io).to receive(:red_notification)
      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)

      player.make_move(board, players)
      expect(board.space(valid_move)).to eql(token)
    end

    it "sends an invalid move error when given an invalid move" do
      invalid_move, valid_move = 9, 0
      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)

      expect(io).to receive(:invalid_move_error)
      player.make_move(board, players)
    end
  end
end
