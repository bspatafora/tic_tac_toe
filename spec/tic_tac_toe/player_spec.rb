require 'tic_tac_toe/board'
require 'tic_tac_toe/io_interface'
require 'tic_tac_toe/player'
require 'tic_tac_toe/spec_helper'

describe TicTacToe::Player do
  let(:board) { TicTacToe::Board.new(row_size: 3) }
  let(:io_interface) { double("io_interface", invalid_move_error: true) }
  let(:players) { double("players") }

  describe '#make_move' do
    let(:decider) { double("decider") }
    let(:token) { "X" }
    let(:needs_to_think) { false }

    let(:player) { TicTacToe::Player.new(decider, token, needs_to_think, io_interface) }
 
    it "only returns a move once it receives a valid move" do
      invalid_space, valid_space = 9, 0
      allow(decider).to receive(:make_move).and_return(invalid_space, valid_space)

      player.make_move(board, players)
      expect(board.space(valid_space)).to eq(token)
    end

    it "displays an invalid move error when given an invalid move" do
      invalid_space, valid_space = 9, 0
      allow(decider).to receive(:make_move).and_return(invalid_space, valid_space)

      expect(io_interface).to receive(:invalid_move_error)
      player.make_move(board, players)
    end
  end
end
