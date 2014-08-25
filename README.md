[![Build Status](https://travis-ci.org/bspatafora/tic_tac_toes.svg?branch=master)](https://travis-ci.org/bspatafora/tic_tac_toes)

# TicTacToes

The game Tic-tac-toe, featuring an unbeatable AI.

## Usage

1. Install [PostgreSQL][]
2. Install the gem: `gem install tic_tac_toes`
3. Create the databases: `set_up_ttt_databases`
    * To drop the databases: `destroy_ttt_databases`
4. Launch the game: `tic_tac_toes`

## Rake tasks
  * `rake` runs the specs
  * `rake set_up_databases` sets up production and test databases
  * `rake destroy_databases` tears down production and test databases

[PostgreSQL]: http://www.postgresql.org
