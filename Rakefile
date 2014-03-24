require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.pattern = "test/*.rb"
end

task :import do
  require "./import_data"
  ImportData.execute
end
