require 'tic_tac_toes/player_factory'

module TicTacToes
  module Rules
    ROW_SIZE_RANGE = (2..10)

    def self.row_size_valid?(row_size)
      row_size.between?(ROW_SIZE_RANGE.min, ROW_SIZE_RANGE.max)
    end

    def self.token_valid?(token, taken_tokens)
      correct_length = token.length == 1
      untaken = !taken_tokens.include?(token)

      correct_length && untaken
    end

    def self.difficulty_valid?(difficulty)
      PlayerFactory::AIS.include? difficulty
    end

    def self.game_over?(board, players)
      winner = !determine_winner(board, players).nil?
      tie = board.full?

      winner || tie
    end

    def self.determine_winner(board, players)
      winner = nil

      players.each do |player|
        player_has_won = win?(board, player)
        winner = player.token if player_has_won
      end

      winner
    end

    def self.win?(board, player)
      diagonal_win?(board, player) ||
      horizontal_win?(board, player) ||
      vertical_win?(board, player)
    end

    private

    def self.diagonal_win?(board, player)
      set_win?(board.diagonals, player)
    end

    def self.horizontal_win?(board, player)
      set_win?(board.rows, player)
    end

    def self.vertical_win?(board, player)
      set_win?(board.columns, player)
    end

    def self.set_win?(sets, player)
      sets.any? { |set| set.all? { |space| space.token == player.token unless space.nil?  } }
    end
  end
end
