require 'pg'

desc 'Set up Tic_tac_toes production and test databases'
task :set_up_databases do
  create_databases
  create_production_tables
end

desc 'Set up just Tic_tac_toes production tables'
task :set_up_tables do
  create_production_tables
end

def create_databases
  connection = PG.connect(dbname: "postgres")

  connection.exec("CREATE DATABASE #{ENV['TTT_DATABASE']}")
  connection.exec("CREATE DATABASE #{ENV['TTT_TEST_DATABASE']}")
end

def create_production_tables
  connection = PG.connect(dbname: ENV['TTT_DATABASE'],
                          host: ENV['TTT_HOST'],
                          port: ENV['TTT_PORT'],
                          user: ENV['TTT_USER'],
                          password: ENV['TTT_PASSWORD'])

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
