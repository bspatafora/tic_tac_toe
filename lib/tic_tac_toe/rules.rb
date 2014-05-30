require 'tic_tac_toe/easy_ai'
require 'tic_tac_toe/medium_ai'
require 'tic_tac_toe/hard_ai'

module TicTacToe
  module Rules
    ROW_SIZE_RANGE = (2..10)
    AI_DIFFICULTIES = { easy: EasyAI, medium: MediumAI, hard: HardAI }

    def self.row_size_valid?(row_size)
      row_size.between?(ROW_SIZE_RANGE.min, ROW_SIZE_RANGE.max)
    end

    def self.token_valid?(token, taken_tokens)
      correct_length = token.length == 1
      untaken = !taken_tokens.include?(token)

      correct_length && untaken
    end

    def self.difficulty_valid?(difficulty)
      AI_DIFFICULTIES.include? difficulty
    end

    def self.game_over?(board, players)
      winner = !determine_winner(board, players).nil?
      tie = board.full?

      winner || tie
    end

    def self.determine_winner(board, players)
      winner = nil

      players.each do |player|
        player_has_won = win?(board, player.token)
        winner = player.token if player_has_won
      end

      winner
    end

    def self.win?(board, token)
      diagonal_win?(board, token) ||
      horizontal_win?(board, token) ||
      vertical_win?(board, token)
    end

    private

    def self.diagonal_win?(board, token)
      set_win?(board.diagonals, token)
    end

    def self.horizontal_win?(board, token)
      set_win?(board.rows, token)
    end

    def self.vertical_win?(board, token)
      set_win?(board.columns, token)
    end

    def self.set_win?(sets, token)
      sets.any? { |set| set.all? { |space| space == token  } }
    end
  end
end
