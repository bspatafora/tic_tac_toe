require 'spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/stringifier'

describe TicTacToe::Stringifier do
  describe '#stringify_board' do
    it "returns a stringified board" do
      leading_spaces_regexp = /^[[:blank:]]+/
      board_string = <<-END.gsub(leading_spaces_regexp, '')

        [0]|[1]|[2]
        -----------
        [3]| X |[5]
        -----------
        [6]|[7]|[8]

      END

      board = TicTacToe::Board.new(row_size: 3)
      board.place(:X, 4)
      expect(TicTacToe::Stringifier.board(board)).to eql(board_string)
    end
  end
end
