require 'pg'

PRODUCTION_DATABASE = 'tic_tac_toes'
TEST_DATABASE = 'tic_tac_toes_test'

desc 'Set up tic_tac_toes production and test databases'
task :set_up_databases do
  create_databases
  create_production_tables
end

def create_databases
  connection = PG.connect(dbname: "postgres")

  connection.exec("CREATE DATABASE #{PRODUCTION_DATABASE}")
  connection.exec("CREATE DATABASE #{TEST_DATABASE}")
end

def create_production_tables
  connection = PG.connect(dbname: "#{PRODUCTION_DATABASE}")

  connection.exec("CREATE TABLE games (
    id serial primary key,
    board_size integer,
    difficulty varchar,
    winner varchar)")
  connection.exec("CREATE TABLE moves (
    game integer REFERENCES games (id),
    number integer,
    token varchar,
    space integer)")
end
