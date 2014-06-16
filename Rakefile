require "bundler/gem_tasks"
require 'pg'

task :create_tables do
  connection = establish_connection
  connection.exec("CREATE TABLE games (
    id serial primary key,
    board_size integer,
    winner varchar)")
  connection.exec("CREATE TABLE moves (
    game integer REFERENCES games (id),
    number integer,
    token varchar,
    space integer)")
end

task :destroy_tables do
  connection = establish_connection
  connection.exec("DROP TABLE moves")
  connection.exec("DROP TABLE games")
end

def establish_connection
  PG.connect(dbname: "tic_tac_toe")
end
