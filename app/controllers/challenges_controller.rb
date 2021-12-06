class ChallengesController < ApplicationController
  
  # Mega dictionary
  def dictionary(rule, value)

    if rule == "challenge_type"
      hash_1 = Hash["1" => "Teams battle", "2" => "Duel", "3" => "Shadow fight"]
      return hash_1[value.to_s]

    elsif rule == "removal_policy"
      hash_2 = Hash["1" => "No week will be removed from the final score", "2" =>"Worst week will be removed from the final score"]
      return hash_2[value.to_s]

    elsif rule == "new_participants_policy"
      hash_3 = Hash["1" => "Only admins can add new participants", "2" =>"New participants cannot be added"]
      return hash_3[value.to_s]

    elsif rule == "minimum_wkt_policy"
      hash_4 = Hash["0" => "No minimum",
                   "1" =>"At least 1",
                   "2" =>"At least 2",
                   "3" =>"At least 3",
                   "4" =>"At least 4",
                   "5" =>"At least 5",
                   "6" =>"At least 6"]
      return hash_4[value.to_s]

    elsif rule == "penalty_policy"
      hash_5 = Hash["1" => "No penalties",
                    "2" => "If minimum workout is not met, a penalty applies"]
      return hash_5[value.to_s]

    elsif rule == "criteria_policy"
      hash_6 = Hash["1" => "Standard: 30 min or 300 calories",
                    "2" => "Brutal: 1 hour or 600 calories"]
      return hash_6[value.to_s]
    end
    
  end
  
  
  
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

    q_handle = params.fetch("query_challenge_handle") 

    if Challenge.exists?(challenge_handle: q_handle)
      redirect_to("/challenges", { :alert => "That handle already exists. Come on, be more creative 🧠"})
    else

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

      # We need to create the privilege
      time = Time.now
      privs = Privilege.new
      privs.user_id = @current_user.id  
      
      # We also need to create the Participation
      part = Participation.new
      part.user_id = @current_user.id
      part.created_at = time
      part.updated_at = time
      
      if the_challenge.valid?
        the_challenge.save
        part.challenge_id = the_challenge.id
        privs.challenge_id = the_challenge.id
        privs.save

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
  end

  def update
    id = params.fetch("path_id")
    @the_challenge = Challenge.where({ :id => id }).at(0)

    @the_challenge.starting_time = params.fetch("query_starting_time")
    @the_challenge.ending_time = params.fetch("query_ending_time")
    @the_challenge.challenge_name = params.fetch("query_challenge_name")

    # @the_challenge.challenge_image = params.fetch("query_challenge_image")
    
    
    
    if params.has_key?("query_challenge_image")

      @the_challenge.challenge_image =  params.fetch("query_challenge_image") 
    #else
    #  @the_challenge.profile_picture = @the_challenge.profile_picture
    end


    
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

    @the_challenge = Challenge.where( {:challenge_handle => handle}).at(0)
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

    @the_challenge = Challenge.where( {:challenge_handle => handle}).at(0)
    challenge_id = @the_challenge.id

    verifly = Privilege.where({:challenge_id => challenge_id}).where({:user_id => user_id}).at(0)
    
    if verifly == nil
      redirect_to("/challenges/#{handle}", { :alert => "You don't have the privilege to invite players to this challenge"} )
    else
      render({ :template => "challenges/invite.html.erb" })
    end
  end

  def rules
    handle = params.fetch("handle")
    user_id = @current_user.id

    @the_challenge = Challenge.where( {:challenge_handle => handle}).at(0)


    @challenge_type = dictionary("challenge_type", @the_challenge.challenge_type)
    @removal_policy = dictionary("removal_policy", @the_challenge.removal_policy)
    @new_participants = dictionary("new_participants_policy", @the_challenge.new_user_policy)
    @minimum_wkt = dictionary("minimum_wkt_policy", @the_challenge.workout_perday_policy)
    @penalty_policy = dictionary("penalty_policy", @the_challenge.penalty_policy)
    @criteria_policy = dictionary("criteria_policy", @the_challenge.workout_criteria)


    render({ :template => "challenges/rules.html.erb" })
  end

  def stats
    handle = params.fetch("handle")

    @the_challenge = Challenge.where( {:challenge_handle => handle}).at(0)
    photoworkouts = Photoworkout.where({:challenge_id => @the_challenge.id})

    id = @the_challenge.id

    big_joint  = photoworkouts.joins(:user, :challenge).where("photoworkouts.challenge_id =?", id).where("challenges.id =?", id)

    @big_table = big_joint#.joins(:teams)

    # Working!
    tester = photoworkouts.joins(:challenge, :participations, :user).where("participations.challenge_id=?", id)

    tim = Team.where({:challenge_id => id})
    tim_dict = tim.pluck(:id, :team_name).to_h
    a = tim_dict.values
    b = tester.group(:team_id).count.values

    @h = Hash[a.zip b]

    render({ :template => "challenges/stats.html.erb" })
  end

  def join
    handle = params.fetch("handle")
    user_id = @current_user.id

    @the_challenge = Challenge.where( {:challenge_handle => handle}).at(0)

    render({ :template => "challenges/join.html.erb" })
  end

  def teams
    @handle = params.fetch("handle")
    user_id = @current_user.id

    @the_challenge = Challenge.where( {:challenge_handle => @handle}).at(0)

    @participants = Participation.where( {:challenge_id => @the_challenge.id}).order({ :team_id => :asc })

    @tims = Team.where({:challenge_id => @the_challenge.id}).order({ :id => :asc })

    @verifly = Privilege.where({:challenge_id => @the_challenge.id})

    verifly_2 = Privilege.where({:challenge_id => @the_challenge.id}).where({:user_id => user_id}).at(0)
    
    if verifly_2 == nil
      redirect_to("/challenges/#{@handle}", { :alert => "You don't have the privilege to edit teams"} )
    else
      render({ :template => "challenges/teams.html.erb" })
    end
  end


end
