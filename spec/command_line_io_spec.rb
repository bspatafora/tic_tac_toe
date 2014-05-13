require 'spec_helper'

describe TicTacToe::CommandLineIO do
  let(:board) { TicTacToe::Board.new }
  let(:game) { TicTacToe::Game.new(board) }
  let(:stringifier) { TicTacToe::Stringifier }
  let(:io) { TicTacToe::CommandLineIO.new(game) }

  describe '#send_move' do
    it "calls ask_for_move" do
      allow(io).to receive(:solicit_move) { 0 }
      expect(io).to receive(:ask_for_move)
      io.send_move
    end

    it "sends the move to its game object" do
      allow(io).to receive(:ask_for_move)
      allow(io).to receive(:solicit_move) { 0 }
      expect(game).to receive(:make_move).with(0)
      io.send_move
    end

    context "when given an invalid move" do
      it "calls invalid_move" do
        allow(io).to receive(:ask_for_move)
        allow(io).to receive(:solicit_move).and_return(9, 0)
        expect(io).to receive(:say_invalid_move).once
        io.send_move
      end

      it "calls itself until it's given a valid move" do
        allow(io).to receive(:ask_for_move)
        allow(io).to receive(:say_invalid_move)
        allow(io).to receive(:solicit_move).and_return(9, 0)
        io.send_move
        expect(board.read(0)).to eql(:X) 
      end
    end
  end

  describe '#ask_for_move' do
    it "asks for a stringified move solicitation message" do
      expect(stringifier).to receive(:stringify_ask_for_move)
      io.ask_for_move
    end
  end

  describe '#say_invalid_move' do
    it "asks for a stringified invalid move message" do
      expect(stringifier).to receive(:stringify_invalid_move)
      io.say_invalid_move
    end
  end

  describe '#say_game_over' do
    it "asks for a stringified game over message" do
      expect(stringifier).to receive(:stringify_game_over).with(:O)
      io.say_game_over(:O)
    end
  end

  describe '#draw_board' do
    it "asks for a stringified representation of its game's board" do
      expect(stringifier).to receive(:stringify_board).with(board)
      io.draw_board
    end
  end
end
