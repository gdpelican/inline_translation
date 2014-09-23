module Babbel
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      namespace "babbel"
      desc "Adds Babbel translations table & initializer"
      source_root File.expand_path '../templates', __FILE__

      def copy_migration
        migration_template "add_babbel_translations.rb", "db/migrate/add_babbel_translations.rb"    
      end

      def copy_initializer
        copy_file "babbel.rb", "config/initializers/babbel.rb"
      end

      def self.next_migration_number(path)
        @previous_migration_nr ||= Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        @previous_migration_nr += 1
      end
    end
  end
end