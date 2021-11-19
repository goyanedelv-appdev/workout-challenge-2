class ParticipationsController < ApplicationController
  def index
    matching_participations = Participation.all

    @list_of_participations = matching_participations.order({ :created_at => :desc })

    render({ :template => "participations/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_participations = Participation.where({ :id => the_id })

    @the_participation = matching_participations.at(0)

    render({ :template => "participations/show.html.erb" })
  end

  def create
    the_participation = Participation.new
    the_participation.user_id = params.fetch("query_user_id")
    the_participation.challenge_id = params.fetch("query_challenge_id")
    the_participation.team_id = params.fetch("query_team_id")

    if the_participation.valid?
      the_participation.save
      redirect_to("/participations", { :notice => "Participation created successfully." })
    else
      redirect_to("/participations", { :notice => "Participation failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_participation = Participation.where({ :id => the_id }).at(0)

    the_participation.user_id = params.fetch("query_user_id")
    the_participation.challenge_id = params.fetch("query_challenge_id")
    the_participation.team_id = params.fetch("query_team_id")

    if the_participation.valid?
      the_participation.save
      redirect_to("/participations/#{the_participation.id}", { :notice => "Participation updated successfully."} )
    else
      redirect_to("/participations/#{the_participation.id}", { :alert => "Participation failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_participation = Participation.where({ :id => the_id }).at(0)

    the_participation.destroy

    redirect_to("/participations", { :notice => "Participation deleted successfully."} )
  end
end
