class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.datetime :starting_time
      t.string :ending_time
      t.string :challenge_name
      t.string :challenge_image
      t.integer :removal_policy
      t.integer :new_user_policy
      t.integer :penalty_policy
      t.integer :workout_perday_policy
      t.integer :workout_criteria
      t.text :prize_policy
      t.string :challenge_handle
      t.integer :number_of_teams
      t.integer :challenge_type

      t.timestamps
    end
  end
end
