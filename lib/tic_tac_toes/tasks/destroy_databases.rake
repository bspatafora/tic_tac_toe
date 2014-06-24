require 'bundler/setup'
require 'rubygems'

require 'pg'

desc 'Drop tic_tac_toes databases'
task :destroy_databases do
  connection = PG.connect(dbname: "postgres")

  connection.exec("DROP DATABASE tic_tac_toes")
  connection.exec("DROP DATABASE tic_tac_toes_test")
end
