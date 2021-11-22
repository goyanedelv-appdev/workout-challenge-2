class ChallengesController < ApplicationController
  def index
    if @current_user == nil
      redirect_to("/user_sign_in") # add a notice
    else
      the_id = @current_user.id

      matching_participations = Participation.where({:user_id => the_id})

      # matching_challenges = Challenge.where({ :id => the_id })

      @list_of_participations = matching_participations.order({ :created_at => :desc })

      render({ :template => "challenges/index.html.erb" })
    end
  end

  def show
    if @current_user == nil
      redirect_to("/user_sign_in") 

    else
      handle = params.fetch("handle")

      matching_challenges = Challenge.where({ :challenge_handle => handle })

      @the_challenge = matching_challenges.at(0)

      @photoworkouts = Photoworkout.where({:challenge_id => @the_challenge.id}).order({ :created_at => :desc })

      render({ :template => "challenges/show.html.erb" })
    end
  end

  def create
    the_challenge = Challenge.new
    the_challenge.starting_time = params.fetch("query_challenge_start_date") # done
    the_challenge.ending_time = params.fetch("query_challenge_finish_date") # done
    the_challenge.challenge_name = params.fetch("query_challenge_name") # done
    the_challenge.challenge_image = params.fetch("query_photo_locator") # done
    the_challenge.removal_policy = params.fetch("query_challenge_removal") # done
    the_challenge.new_user_policy = params.fetch("query_new_user_policy") # done
    the_challenge.penalty_policy = params.fetch("query_challenge_penalty") # done
    the_challenge.workout_perday_policy = params.fetch("query_challenge_minimum") # done
    the_challenge.workout_criteria = params.fetch("query_challenge_criteria") # done
    the_challenge.prize_policy = params.fetch("query_challenge_prize") # done
    the_challenge.challenge_handle = params.fetch("query_challenge_handle") # done
    the_challenge.number_of_teams = params.fetch("query_challenge_team_numbers") #done
    the_challenge.challenge_type = params.fetch("query_challenge_type") # done

    # We also need to create the Participation
    time = Time.now
    part = Participation.new
    part.user_id = @current_user.id
    part.created_at = time
    part.updated_at = time
    
    if the_challenge.valid?
      the_challenge.save
      part.challenge_id = the_challenge.id

      the_challenge.number_of_teams.times do |num|
        tim = Team.new
        tim.team_name = "Team #{num + 1}"
        tim.team_picture = "default"
        tim.challenge_id = the_challenge.id
        tim.created_at = time
        tim.updated_at = time
        tim.save
      end

      part.team_id = Team.pluck(:id).max - the_challenge.number_of_teams + 1
      part.save

      redirect_to("/challenges", { :notice => "Challenge created successfully." })
    else
      redirect_to("/challenges", { :notice => "Challenge failed to create successfully." })
    end
  end

  def update
    id = params.fetch("path_id")
    @the_challenge = Challenge.where({ :id => id }).at(0)

    @the_challenge.starting_time = params.fetch("query_starting_time")
    @the_challenge.ending_time = params.fetch("query_ending_time")
    @the_challenge.challenge_name = params.fetch("query_challenge_name")
    @the_challenge.challenge_image = params.fetch("query_challenge_image")
    @the_challenge.removal_policy = params.fetch("query_removal_policy")
    @the_challenge.new_user_policy = params.fetch("query_new_user_policy")
    @the_challenge.penalty_policy = params.fetch("query_penalty_policy")
    @the_challenge.workout_perday_policy = params.fetch("query_workout_perday_policy")
    @the_challenge.workout_criteria = params.fetch("query_workout_criteria")
    @the_challenge.prize_policy = params.fetch("query_prize_policy")
    @the_challenge.challenge_handle = params.fetch("query_challenge_handle")
    @the_challenge.number_of_teams = params.fetch("query_number_of_teams")
    @the_challenge.challenge_type = params.fetch("query_challenge_type")

    if @the_challenge.valid?
      @the_challenge.save
      redirect_to("/challenges/#{@the_challenge.challenge_handle}", { :notice => "Challenge updated successfully."} )
    else
      redirect_to("/challenges/#{@the_challenge.challenge_handle}", { :alert => "Challenge failed to update successfully." })
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

  def edit
    handle = params.fetch("handle")
    user_id = @current_user.id

    @the_challenge = Challenge.where( :challenge_handle => handle).at(0)
    challenge_id = @the_challenge.id

    verifly = Privilege.where({:challenge_id => challenge_id}).where({:user_id => user_id}).at(0)
    
    if verifly == nil
      redirect_to("/challenges/#{handle}", { :alert => "You don't have the privilege to edit this challenge"} )
    else
      render({ :template => "challenges/edit.html.erb" })
    end
  end

  def invite
    handle = params.fetch("handle")
    user_id = @current_user.id

    @the_challenge = Challenge.where( :challenge_handle => handle).at(0)
    challenge_id = @the_challenge.id

    verifly = Privilege.where({:challenge_id => challenge_id}).where({:user_id => user_id}).at(0)
    
    if verifly == nil
      redirect_to("/challenges/#{handle}", { :alert => "You don't have the privilege to invite players to this challenge"} )
    else
      render({ :template => "challenges/invite.html.erb" })
    end
  end

  def rules

    render({ :template => "challenges/rules.html.erb" })
  end

  def stats

    render({ :template => "challenges/stats.html.erb" })
  end

  def join
    handle = params.fetch("handle")
    user_id = @current_user.id

    @the_challenge = Challenge.where( :challenge_handle => handle).at(0)

    render({ :template => "challenges/join.html.erb" })
  end


end
