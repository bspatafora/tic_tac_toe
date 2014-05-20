require 'tic_tac_toe/easy_ai'
require 'tic_tac_toe/hard_ai'

module TicTacToe
  module MediumAI
    def self.make_move(board, players)
      ai = [EasyAI, HardAI].sample
      ai.make_move(board, players)
    end
  end
end
