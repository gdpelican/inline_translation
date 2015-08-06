class AddInlineTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.integer :translatable_id
      t.string  :translatable_type
      t.string  :field
      t.string  :language
      t.text    :translation
      t.timestamps
    end
  end

  def self.down
    drop_table :translations
  end
end
