class CreateClientRedirectUris < ActiveRecord::Migration[6.0]
  def change
    create_table :client_redirect_uris do |t|
      t.string :uri, null: false
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
