class PhotoworkoutsController < ApplicationController
  
  def new

    if @current_user == nil
      redirect_to("/user_sign_in")
    else
      render({ :template => "photoworkouts/new.html.erb" })
    end
  end
  
  
  def index
    matching_photoworkouts = Photoworkout.all

    @list_of_photoworkouts = matching_photoworkouts.order({ :created_at => :desc })

    render({ :template => "photoworkouts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_photoworkouts = Photoworkout.where({ :id => the_id })

    @the_photoworkout = matching_photoworkouts.at(0)

    render({ :template => "photoworkouts/show.html.erb" })
  end

  def create
    the_photoworkout = Photoworkout.new
    the_photoworkout.caption = params.fetch("query_caption")
    the_photoworkout.challenge_id = params.fetch("query_challenge_id")
    the_photoworkout.user_id = params.fetch("query_user_id")
    the_photoworkout.likes_count = params.fetch("query_likes_count")
    the_photoworkout.photo_locator = params.fetch("query_photo_locator")
    the_photoworkout.calories = params.fetch("query_calories")
    the_photoworkout.main_exercise = params.fetch("query_main_exercise")

    if the_photoworkout.valid?
      the_photoworkout.save
      redirect_to("/photoworkouts", { :notice => "Photoworkout created successfully." })
    else
      redirect_to("/photoworkouts", { :notice => "Photoworkout failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photoworkout = Photoworkout.where({ :id => the_id }).at(0)

    the_photoworkout.caption = params.fetch("query_caption")
    the_photoworkout.challenge_id = params.fetch("query_challenge_id")
    the_photoworkout.user_id = params.fetch("query_user_id")
    the_photoworkout.likes_count = params.fetch("query_likes_count")
    the_photoworkout.photo_locator = params.fetch("query_photo_locator")
    the_photoworkout.calories = params.fetch("query_calories")
    the_photoworkout.main_exercise = params.fetch("query_main_exercise")

    if the_photoworkout.valid?
      the_photoworkout.save
      redirect_to("/photoworkouts/#{the_photoworkout.id}", { :notice => "Photoworkout updated successfully."} )
    else
      redirect_to("/photoworkouts/#{the_photoworkout.id}", { :alert => "Photoworkout failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photoworkout = Photoworkout.where({ :id => the_id }).at(0)

    the_photoworkout.destroy

    redirect_to("/photoworkouts", { :notice => "Photoworkout deleted successfully."} )
  end
end
