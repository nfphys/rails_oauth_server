class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :uuid, null: false
      t.string :secret_digest, null: false
      t.string :scope

      t.timestamps
    end
  end
end
