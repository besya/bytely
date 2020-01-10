class Links < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :token, null: false
      t.integer :redirects, default: 0, null: false
    end

    add_index :links, :url, unique: true
    add_index :links, :token, unique: true
  end
end
