module TicTacToe
  class CommandLineRunner
    def initialize(game, computer, io)
      @game = game
      @computer = computer
      @io = io
    end

    def play
      if @game.over?
        @io.draw_board
        @io.say_game_over(@game.determine_winner)
      else
        @io.draw_board
        @game.tokens.first == :X ? @io.send_move : @game.place(@computer.make_move)
        play
      end
    end
  end
end
