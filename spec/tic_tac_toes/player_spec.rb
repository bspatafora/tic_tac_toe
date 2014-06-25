require 'tic_tac_toes/board'
require 'tic_tac_toes/player'
require 'tic_tac_toes/spec_helper'

describe TicTacToes::Player do
  let(:board) { TicTacToes::Board.new(row_size: 3) }
  let(:io_interface) { double("io_interface", invalid_move_error: true) }
  let(:players) { double("players") }

  describe '#place_and_return_move' do
    let(:move_strategy) { double("move_strategy") }
    let(:token) { "X" }
    let(:needs_to_think) { false }

    let(:player) { TicTacToes::Player.new(move_strategy, token, needs_to_think, io_interface) }
 
    it "only places/returns a move once it receives a valid move" do
      invalid_space, valid_space = 9, 0
      allow(move_strategy).to receive(:move).and_return(invalid_space, valid_space)

      player.place_and_return_move(board, players)
      expect(board.space(valid_space)).to eq(player)
    end

    it "displays an invalid move error when given an invalid move" do
      invalid_space, valid_space = 9, 0
      allow(move_strategy).to receive(:move).and_return(invalid_space, valid_space)

      expect(io_interface).to receive(:invalid_move_error)
      player.place_and_return_move(board, players)
    end
  end
end
