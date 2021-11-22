class PrivilegesController < ApplicationController
  # to be deleted
  def index
    matching_privileges = Privilege.all

    @list_of_privileges = matching_privileges.order({ :created_at => :desc })

    render({ :template => "privileges/index.html.erb" })
  end

  # to be deleted
  def show
    the_id = params.fetch("path_id")

    matching_privileges = Privilege.where({ :id => the_id })

    @the_privilege = matching_privileges.at(0)

    render({ :template => "privileges/show.html.erb" })
  end

  # in use
  def create
    that_user = params.fetch("user_id")
    handle = params.fetch("handle")

    challenge_id = Challenge.where({:challenge_handle => handle}).at(0).id

    the_privilege = Privilege.new
    the_privilege.challenge_id = challenge_id
    the_privilege.user_id = that_user

    if the_privilege.valid?
      the_privilege.save
      redirect_to("/challenges/#{handle}/teams", { :notice => "Admin privilege created successfully." })
    else
      redirect_to("/challenges/#{handle}/teams", { :notice => "Admin privilege failed to create successfully." })
    end
  end

  # to be deleted
  def update
    the_id = params.fetch("path_id")
    the_privilege = Privilege.where({ :id => the_id }).at(0)

    the_privilege.challenge_id = params.fetch("query_challenge_id")
    the_privilege.user_id = params.fetch("query_user_id")

    if the_privilege.valid?
      the_privilege.save
      redirect_to("/privileges/#{the_privilege.id}", { :notice => "Privilege updated successfully."} )
    else
      redirect_to("/privileges/#{the_privilege.id}", { :alert => "Privilege failed to update successfully." })
    end
  end

  # in use
  def destroy
    user_id = params.fetch("user_id")
    handle = params.fetch("handle")

    challenge_id = Challenge.where({:challenge_handle => handle}).at(0).id

    the_privilege = Privilege.where({ :user_id => user_id }).where({ :challenge_id => challenge_id }).at(0)

    the_privilege.destroy

    redirect_to("/challenges/#{handle}/teams", { :notice => "Admin privilege deleted successfully."} )
  end
end
