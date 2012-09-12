require 'thor'
require 'rails/generators/actions'
require 'database_cleaner'

module SCV
  class CLI < ::Thor
    include Thor::Actions
    include Rails::Generators::Actions
    add_runtime_options!

    default_task(:reset)

    desc "bootstrap", "Initially sets up the application"
    def bootstrap
      invoke :config, [], :force => true
      invoke :db, [], :seed => false
      invoke :populate, :truncate => false
    end

    desc "reset", "Drops and recreates the database with test data"
    def reset
      invoke :db, [], :drop => true, :seed => false
      invoke :populate, [], :truncate => false
    end

    desc "config [--force] [--quiet] [--pretend] [--skip]", "copy example configuration files to config directory"
    def config
      source_paths.push(destination_root = ".")
      directory("config/examples", "config")
    end

    desc "db", "initialize db and load schema"
    method_option :drop, :type => :boolean, :default => false, :aliases => '-d'
    method_option :seed, :type => :boolean, :default => true, :aliases => '-s'
    def db
      rake([].tap do |commands|
        commands.push "db:drop" if options.drop?
        commands.push "db:create"
        commands.push "db:migrate"
        commands.push "db:seed" if options.seed?
        commands.push "db:test:prepare"
      end.join(" "))
    end

    desc "populate", "populate database with test data"
    method_option :truncate, :type => :boolean, :default => true, :aliases => "-t"
    def populate
      log :load, "environment"
      require './config/environment'

      if options.truncate?
        log :truncate, "database"
        DatabaseCleaner.clean_with(:truncation)
      end
      load_seed_file("db/seeds.rb")
      load_seed_file("db/populate.rb")
    end

    private

    def load_seed_file(file)
      if File.exist?(file)
        log :load, file
        load(file)
      end
    end
  end
end
