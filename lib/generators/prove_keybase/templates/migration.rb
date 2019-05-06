class CreateKeybaseProofs < ActiveRecord::Migration[5.2]
  def change
    create_table :keybase_proofs do |t|

      # If `User` is not the correct model, update this line
      t.belongs_to :user, foreign_key: { on_delete: :cascade }

      t.string :username, null: false, default: ''
      t.string :kb_username, null: false, default: ''
      t.text :token, null: false, default: ''
      t.boolean :proof_valid
      t.boolean :proof_live

      t.timestamps null: false
    end

    add_index :keybase_proofs, [:username, :kb_username], unique: true, name: :index_kb_proofs_on_local_user
  end
end
