desc "Starts the application server on port 4567"
task :server do
  exec "ruby app.rb"
end

desc "Imports summer departures"
task :import do
  exec "./bin/import ljetni"
end

require "rake/testtask"
Rake::TestTask.new do |t|
    t.pattern = "test/*.rb"
end

task :default => :test
