require 'spec_helper'
require 'tic_tac_toe/player'

describe TicTacToe::Player do
  let(:decider) { double("test decider") }


  describe '#initialize' do
    it "doesn't accept non-single-character tokens" do
      invalid_token, taken_tokens = :invalid, []

      expect { TicTacToe::Player.new(decider, invalid_token, taken_tokens) }.
        to raise_error(TicTacToe::InvalidToken)
    end

    it "doesn't accept already-taken tokens" do
      invalid_token, taken_tokens = :X, [:X]

      expect { TicTacToe::Player.new(decider, invalid_token, taken_tokens) }.
        to raise_error(TicTacToe::InvalidToken)
    end

    it "returns new player objects with the correct token when given single-character, untaken tokens" do
      valid_token, taken_tokens = :X, []

      player = TicTacToe::Player.new(decider, valid_token, taken_tokens)
      expect(player.token).to eql(valid_token)
    end
  end


  describe '#make_move' do
    let(:board) { TicTacToe::Board.new(row_size: 3) }
    let(:players) { double("players") }

    it "only returns a move once it receives a valid move" do
      token, taken_tokens = :X, []
      player = TicTacToe::Player.new(decider, token, taken_tokens)
      invalid_move, valid_move = 9, 0

      allow(player.decider).to receive(:make_move).and_return(invalid_move, valid_move)
      player.make_move(board, players)
      expect(board.space(valid_move)).to eql(token)
    end
  end
end
