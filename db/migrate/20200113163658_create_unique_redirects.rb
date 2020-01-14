class CreateUniqueRedirects < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :unique_redirects_count, :integer, default: 0, null: false
    add_column :countries, :unique_redirects_count, :integer, default: 0, null: false

    create_table :unique_redirects do |t|
      t.belongs_to :link
      t.belongs_to :country
      t.string :ip, null: false, default: '0.0.0.0'
    end

    add_index :unique_redirects, %i[ip link_id], unique: true

    add_column :redirects, :unique_redirect_id, :integer, null: false, index: true
    add_column :unique_redirects, :redirects_count, :integer, default: 0, null: false
  end
end
