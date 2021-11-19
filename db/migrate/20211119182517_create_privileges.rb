class CreatePrivileges < ActiveRecord::Migration[6.0]
  def change
    create_table :privileges do |t|
      t.integer :challenge_id
      t.integer :user_id

      t.timestamps
    end
  end
end
