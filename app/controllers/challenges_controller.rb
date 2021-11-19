class ChallengesController < ApplicationController
  def index
    matching_challenges = Challenge.all

    @list_of_challenges = matching_challenges.order({ :created_at => :desc })

    render({ :template => "challenges/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_challenges = Challenge.where({ :id => the_id })

    @the_challenge = matching_challenges.at(0)

    render({ :template => "challenges/show.html.erb" })
  end

  def create
    the_challenge = Challenge.new
    the_challenge.starting_time = params.fetch("query_starting_time")
    the_challenge.ending_time = params.fetch("query_ending_time")
    the_challenge.challenge_name = params.fetch("query_challenge_name")
    the_challenge.challenge_image = params.fetch("query_challenge_image")
    the_challenge.removal_policy = params.fetch("query_removal_policy")
    the_challenge.new_user_policy = params.fetch("query_new_user_policy")
    the_challenge.penalty_policy = params.fetch("query_penalty_policy")
    the_challenge.workout_perday_policy = params.fetch("query_workout_perday_policy")
    the_challenge.workout_criteria = params.fetch("query_workout_criteria")
    the_challenge.prize_policy = params.fetch("query_prize_policy")
    the_challenge.challenge_handle = params.fetch("query_challenge_handle")
    the_challenge.number_of_teams = params.fetch("query_number_of_teams")
    the_challenge.challenge_type = params.fetch("query_challenge_type")

    if the_challenge.valid?
      the_challenge.save
      redirect_to("/challenges", { :notice => "Challenge created successfully." })
    else
      redirect_to("/challenges", { :notice => "Challenge failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_challenge = Challenge.where({ :id => the_id }).at(0)

    the_challenge.starting_time = params.fetch("query_starting_time")
    the_challenge.ending_time = params.fetch("query_ending_time")
    the_challenge.challenge_name = params.fetch("query_challenge_name")
    the_challenge.challenge_image = params.fetch("query_challenge_image")
    the_challenge.removal_policy = params.fetch("query_removal_policy")
    the_challenge.new_user_policy = params.fetch("query_new_user_policy")
    the_challenge.penalty_policy = params.fetch("query_penalty_policy")
    the_challenge.workout_perday_policy = params.fetch("query_workout_perday_policy")
    the_challenge.workout_criteria = params.fetch("query_workout_criteria")
    the_challenge.prize_policy = params.fetch("query_prize_policy")
    the_challenge.challenge_handle = params.fetch("query_challenge_handle")
    the_challenge.number_of_teams = params.fetch("query_number_of_teams")
    the_challenge.challenge_type = params.fetch("query_challenge_type")

    if the_challenge.valid?
      the_challenge.save
      redirect_to("/challenges/#{the_challenge.id}", { :notice => "Challenge updated successfully."} )
    else
      redirect_to("/challenges/#{the_challenge.id}", { :alert => "Challenge failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_challenge = Challenge.where({ :id => the_id }).at(0)

    the_challenge.destroy

    redirect_to("/challenges", { :notice => "Challenge deleted successfully."} )
  end

  def new
    render({ :template => "challenges/new.html.erb" })

  end
end
