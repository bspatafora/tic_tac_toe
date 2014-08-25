require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

load './lib/tic_tac_toes/tasks/set_up_databases.rake'
load './lib/tic_tac_toes/tasks/destroy_databases.rake'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
