class CreateParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.integer :team_id

      t.timestamps
    end
  end
end
