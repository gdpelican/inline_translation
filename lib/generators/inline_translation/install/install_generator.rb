module InlineTranslation
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    desc "Adds InlineTranslation translations table & initializer"
    source_root File.expand_path '../templates', __FILE__

    def copy_migration
      migration_template "add_inline_translations.rb", "db/migrate/add_inline_translations.rb"
    end

    def copy_initializer
      copy_file "inline_translation.rb", "config/initializers/inline_translation.rb"
    end

    def copy_js_view
      copy_file "create.js.erb", "app/views/translations/create.js.erb"
    end

    def self.next_migration_number(path)
      @previous_migration_nr ||= Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      @previous_migration_nr += 1
    end
  end
end
