class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients, id: :string do |t|
      t.string :secret_digest, null: false
      t.string :scope

      t.timestamps
    end
  end
end
