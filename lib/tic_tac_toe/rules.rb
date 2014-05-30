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
      back_diagonal, front_diagonal = true, true

      board.rows.each_with_index do |row, index|
        back_diagonal_space = row[index]
        front_diagonal_space = row[board.row_size - (index + 1)]

        back_diagonal = false if back_diagonal_space != token
        front_diagonal = false if front_diagonal_space != token
      end

      back_diagonal || front_diagonal
    end

    def self.horizontal_win?(board, token)
      row_win?(board.rows, token)
    end

    def self.vertical_win?(board, token)
      transposed_rows = board.rows.transpose
      row_win?(transposed_rows, token)
    end

    def self.row_win?(rows, token)
      rows.any? { |row| row.all? { |space| space == token  } }
    end
  end
end
