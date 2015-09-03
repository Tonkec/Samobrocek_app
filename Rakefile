require "pry"
desc "Starts the application server on port 4567"
task :server do
  exec "shotgun app.rb"
end

namespace :db do
  desc "drops database"
  task :drop do
    require "./lib/database"
    Database.load
    Mongoid.purge!
  end

  namespace :import do
    desc "Imports summer departures"
    task :summer => [:drop] do
      exec "mongorestore data/summer"
    end

    desc "Imports winter departures"
    task :winter => [:drop] do
      exec "mongorestore data/winter"
    end
  end
end

require "rake/testtask"
Rake::TestTask.new do |t|
    t.pattern = "test/*.rb"
end

task :default => :test

namespace :sass do
  desc "compile sass to css"
  task :compile do
    check_node_sass_present do
      exec "node-sass public/sass/style.scss public/style.css"
    end
  end

  desc "observe sass changes and compile on the fly"
  task :watch do
    check_node_sass_present do
      exec "node-sass public/sass/style.scss --watch public/style.css"
    end
  end
end

desc "start mongodb server"
task :mongo do
  exec "mongod --dbpath data"
end

desc "deploy to kadcezucko.info"
task :deploy do
  exec "ssh core@kadcezucko.info 'cd zucko; git pull'"
end

def check_node_sass_present
  yield
rescue => ex
  if ex.message =~ /No such file or directory - node-sass/
    puts
    puts "You don't have node-sass installed, install it with:"
    puts "    npm install -g node-sass"
    puts
  else
    raise ex
  end
end
