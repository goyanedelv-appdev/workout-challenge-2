class PrivilegesController < ApplicationController
  def index
    matching_privileges = Privilege.all

    @list_of_privileges = matching_privileges.order({ :created_at => :desc })

    render({ :template => "privileges/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_privileges = Privilege.where({ :id => the_id })

    @the_privilege = matching_privileges.at(0)

    render({ :template => "privileges/show.html.erb" })
  end

  def create
    the_privilege = Privilege.new
    the_privilege.challenge_id = params.fetch("query_challenge_id")
    the_privilege.user_id = params.fetch("query_user_id")

    if the_privilege.valid?
      the_privilege.save
      redirect_to("/privileges", { :notice => "Privilege created successfully." })
    else
      redirect_to("/privileges", { :notice => "Privilege failed to create successfully." })
    end
  end

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

  def destroy
    the_id = params.fetch("path_id")
    the_privilege = Privilege.where({ :id => the_id }).at(0)

    the_privilege.destroy

    redirect_to("/privileges", { :notice => "Privilege deleted successfully."} )
  end
end
