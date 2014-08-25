require 'pg'

desc 'Drop Tic_tac_toes production and test databases'
task :destroy_databases do
  connection = PG.connect(dbname: "postgres")

  connection.exec("DROP DATABASE tic_tac_toes")
  connection.exec("DROP DATABASE tic_tac_toes_test")
end
