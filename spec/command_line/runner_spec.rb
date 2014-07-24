require 'command_line/runner'

describe CommandLine::Runner do
  describe '#run' do
    let(:game_state) { double(board: 'board', players: 'players', game_over: true) }

    let(:io)                  { double(draw_board: true,
                                       thinking_notification: true,
                                       game_over_notification: true) }
    let(:menu)                { double(get_board: true,
                                       get_players: true) }
    let(:game_state)          { double(board: 'board',
                                       players: 'players',
                                       game_over: true,
                                       game_over?: true,
                                       determine_winner: true) }
    let(:game_state_factory)  { double(generate_game_state: game_state) }

    let(:runner)              { CommandLine::Runner.new(io,
                                                        menu,
                                                        game_state_factory) }

    it 'gets an initial game state' do
      expect(game_state_factory).to receive(:generate_game_state)
      runner.run
    end

    it 'takes turns until the game is over' do
      allow(game_state).to receive(:game_over?).and_return(false, true)

      expect(runner).to receive(:take_turn).once
      runner.run
    end

    it 'ends the game when the game is over' do
      expect(runner).to receive(:end_game)
      runner.run
    end
  end
end
