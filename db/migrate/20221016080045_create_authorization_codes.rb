class CreateAuthorizationCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :authorization_codes do |t|
      t.string :code, null: false
      t.string :scope
      t.string :redirect_uri, null: false
      t.string :state, null: false
      t.string :client_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_foreign_key :authorization_codes, :clients
    add_index :authorization_codes, :client_id
    add_index :authorization_codes, :code
  end
end
