class CreateAuthorizationCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :authorization_codes do |t|
      t.string :code_digest, null: false
      t.string :scope
      t.string :redirect_uri, null: false
      t.string :state, null: false
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
