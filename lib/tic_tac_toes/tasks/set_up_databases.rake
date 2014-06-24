require 'pg'
require 'rubygems'

PRODUCTION_DATABASE = 'tic_tac_toes'
TEST_DATABASE = 'tic_tac_toes_test'

desc 'Set up tic_tac_toes databases'
task :set_up_databases do
  create_databases_if_not_exist
  create_production_tables_if_not_exist
end

def create_databases_if_not_exist
  connection = PG.connect(dbname: "postgres")

  connection.exec("CREATE DATABASE #{PRODUCTION_DATABASE}") unless already_exists?(PRODUCTION_DATABASE, connection)
  connection.exec("CREATE DATABASE #{TEST_DATABASE}") unless already_exists?(TEST_DATABASE, connection)
end

def already_exists?(database, connection)
  existing_ttt_database_result = connection.exec("SELECT COUNT(*) FROM pg_database WHERE datname = '#{database}'")
  number_of_existing_ttt_databases = existing_ttt_database_result.getvalue(0,0).to_i

  number_of_existing_ttt_databases == 1 ? true : false
end

def create_production_tables_if_not_exist
  connection = PG.connect(dbname: "#{PRODUCTION_DATABASE}")

  # Suppress "already exist" notices
  connection.exec("set client_min_messages=warning")

  connection.exec("CREATE TABLE IF NOT EXISTS games (
    id serial primary key,
    board_size integer,
    winner varchar)")
  connection.exec("CREATE TABLE IF NOT EXISTS moves (
    game integer REFERENCES games (id),
    number integer,
    token varchar,
    space integer)")
end
