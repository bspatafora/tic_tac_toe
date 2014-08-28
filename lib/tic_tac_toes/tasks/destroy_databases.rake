require 'pg'

desc 'Drop Tic_tac_toes production and test databases'
task :destroy_databases do
  connection = PG.connect(dbname: "postgres")

  connection.exec("DROP DATABASE #{ENV['TTT_DATABASE']}")
  connection.exec("DROP DATABASE #{ENV['TTT_TEST_DATABASE']}")
end
