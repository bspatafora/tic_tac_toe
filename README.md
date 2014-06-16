# TicTacToes

The game Tic-tac-toe, featuring an unbeatable AI.

## Usage

1. Install [PostgreSQL][]
2. Create the game history database: `createdb tic_tac_toes`
3. Install the gem: `gem install tic_tac_toes`
4. From the tic\_tac\_toes gem directory, create the database tables: `rake create_tables`
    * To find your gems directory, use `gem environment` and note what's listed under "GEM PATHS"
5. Launch the game: `tic_tac_toes`

[PostgreSQL]: http://www.postgresql.org
