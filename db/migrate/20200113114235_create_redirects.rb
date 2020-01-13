class CreateRedirects < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false, default: 'Unknown'
      t.integer :redirects_count, default: 0
    end

    add_index :countries, :name, unique: true

    create_table :redirects do |t|
      t.belongs_to :link
      t.belongs_to :country
      t.string :ip, null: false, default: '0.0.0.0'
    end

    rename_column :links, :redirects, :redirects_count
  end
end
