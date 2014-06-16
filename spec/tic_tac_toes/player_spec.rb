require 'tic_tac_toes/board'
require 'tic_tac_toes/io_interface'
require 'tic_tac_toes/player'
require 'tic_tac_toes/spec_helper'

describe TicTacToes::Player do
  let(:board) { TicTacToes::Board.new(row_size: 3) }
  let(:io_interface) { double("io_interface", invalid_move_error: true) }
  let(:players) { double("players") }

  describe '#make_move' do
    let(:decider) { double("decider") }
    let(:token) { "X" }
    let(:needs_to_think) { false }

    let(:player) { TicTacToes::Player.new(decider, token, needs_to_think, io_interface) }
 
    it "only returns a move once it receives a valid move" do
      invalid_space, valid_space = 9, 0
      allow(decider).to receive(:make_move).and_return(invalid_space, valid_space)

      player.make_move(board, players)
      expect(board.space(valid_space)).to eq(player)
    end

    it "displays an invalid move error when given an invalid move" do
      invalid_space, valid_space = 9, 0
      allow(decider).to receive(:make_move).and_return(invalid_space, valid_space)

      expect(io_interface).to receive(:invalid_move_error)
      player.make_move(board, players)
    end
  end
end
