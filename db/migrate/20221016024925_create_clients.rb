class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :client_id, null: false
      t.string :client_secret_digest, null: false
      t.string :scope

      t.timestamps
    end
  end
end
