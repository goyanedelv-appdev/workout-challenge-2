class ParticipationsController < ApplicationController
  
  # TO BE DELETED
  def index
    matching_participations = Participation.all

    @list_of_participations = matching_participations.order({ :created_at => :desc })

    render({ :template => "participations/index.html.erb" })
  end

  # TO BE DELETED
  def show
    the_id = params.fetch("path_id")

    matching_participations = Participation.where({ :id => the_id })

    @the_participation = matching_participations.at(0)

    render({ :template => "participations/show.html.erb" })
  end

  # IN USE
  def create # Create a participation from the shared link
    
    the_participation = Participation.new
    handle = params.fetch("handle")
    challenge_id = Challenge.where({:challenge_handle => handle}).at(0).id
    tim = Participation.where({:challenge_id => challenge_id}).at(0).team_id
    
    verifly = Participation.where({:user_id => @current_user.id}).where({:challenge_id => challenge_id }).at(0)
    
    if verifly == nil
    
      the_participation.user_id = @current_user.id
      the_participation.challenge_id = challenge_id
      the_participation.team_id = tim

      if the_participation.valid?
        the_participation.save
        redirect_to("/challenges/#{handle}", { :notice => "You joined the challenge succesfully" })
      else
        redirect_to("/challenges", { :alert => "You failed to join the challenge." })
      end
    else
      redirect_to("/challenges/#{handle}", { :alert => "You are already in the challenge. No need to join again!" })
    end
  end

  # IN USE!
  def update
    @handle = params.fetch("handle")

    the_id = Challenge.where({:challenge_handle => @handle}).at(0).id

    that_user = params.fetch("query_that_user")

    the_participation = Participation.where({ :challenge_id => the_id }).where({:user_id => that_user}).at(0)

    the_participation.team_id = params.fetch("query_team_id")

    if the_participation.valid?
      the_participation.save
      redirect_to("/challenges/#{@handle}/teams", { :notice => "Teams updated successfully."} )
    else
      redirect_to("/challenges/#{@handle}/teams", { :alert => "Teams failed to update successfully." })
    end
  end

  # MIGHT USE IT
  def destroy
    the_id = params.fetch("path_id")
    the_participation = Participation.where({ :id => the_id }).at(0)

    the_participation.destroy

    redirect_to("/participations", { :notice => "Participation deleted successfully."} )
  end
end
