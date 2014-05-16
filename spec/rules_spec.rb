require 'spec_helper'

describe TicTacToe::Rules do
  let(:human_player) { double("human player", :token => :X) }
  let(:computer_player) { double("computer player", :token => :O) }
  let(:players) { [human_player, computer_player] }
  let(:rules) { TicTacToe::Rules }


  describe '#game_over?' do
    it "returns false if the game is not over" do
      structure = [:X, :X, :O,
                   :O, :O, nil,
                   :X, :O, :X]
      board = generate_board(structure)
      expect(rules.game_over?(players, board)).to be false
    end

    it "returns true if there is a winner" do
      structure = [:X, nil, nil,
                   nil, :X, nil,
                   nil, nil, :X]
      board = generate_board(structure)
      expect(rules.game_over?(players, board)).to be true
    end

    it "returns true if there is a draw" do
      structure = [:X, :X, :O,
                   :O, :O, :X,
                   :X, :O, :X]
      board = generate_board(structure)
      expect(rules.game_over?(players, board)).to be true
    end
  end


  describe '#determine_winner' do
    it "returns the winning token when there is a winner" do
      structure = [:O, nil, nil,
                   nil, :O, nil,
                   nil, nil, :O]
      board = generate_board(structure)
      expect(rules.determine_winner(players, board)).to eql(:O)
    end

    it "returns something falsey if there is not a winner" do
      structure = [:X, :X, :O,
                   :O, :O, nil,
                   :X, :O, :X]
      board = generate_board(structure)
      expect(rules.determine_winner(players, board)).to be_false
    end
  end


  describe '#win?' do
    it "returns false if a token has not won" do
      structure = [:X, :X, :O,
                   :O, :O, nil,
                   :X, :O, :X]
      board = generate_board(structure)
      expect(rules.win?(:X, board)).to be false
    end

    it "returns true if a token has achieved a back diagonal win" do
      structure = [:X, nil, nil,
                   nil, :X, nil,
                   nil, nil, :X]
      board = generate_board(structure)
      expect(rules.win?(:X, board)).to be true
    end

    it "returns true if a token has achieved a front diagonal win" do
      structure = [nil, nil, :X,
                   nil, :X, nil,
                   :X, nil, nil]
      board = generate_board(structure)
      expect(rules.win?(:X, board)).to be true
    end

    it "returns true if a token has achieved a horizonatal win" do
      structure = [nil, nil, nil,
                   :X, :X, :X,
                   nil, nil, nil]
      board = generate_board(structure)
      expect(rules.win?(:X, board)).to be true
    end

    it "returns true if a token has achieved a vertical win" do
      structure = [nil, :X, nil,
                   nil, :X, nil,
                   nil, :X, nil]
      board = generate_board(structure)
      expect(rules.win?(:X, board)).to be true
    end
  end
end
