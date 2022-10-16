class CreateClientRedirectUris < ActiveRecord::Migration[6.0]
  def change
    create_table :client_redirect_uris do |t|
      t.string :uri, null: false
      t.string :client_id, null: false

      t.timestamps
    end
    add_foreign_key :client_redirect_uris, :clients
    add_index :client_redirect_uris, :client_id
  end
end
