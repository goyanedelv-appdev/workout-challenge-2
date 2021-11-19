class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :team_picture
      t.integer :challenge_id

      t.timestamps
    end
  end
end
