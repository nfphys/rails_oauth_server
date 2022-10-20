class CreateAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :access_tokens do |t|
      t.string :token, null: false
      t.string :scope
      t.datetime :expires_at, null: false
      t.string :client_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_foreign_key :access_tokens, :clients
    add_index :access_tokens, :client_id
  end
end
