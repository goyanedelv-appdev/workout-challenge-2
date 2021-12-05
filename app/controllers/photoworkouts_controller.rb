class PhotoworkoutsController < ApplicationController
  
  def new

    @handle = params.fetch("handle")

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

    @workout = matching_photoworkouts.at(0)
    @the_challenge = Challenge.where({:id => @workout.challenge_id}).at(0)

    render({ :template => "photoworkouts/show.html.erb" })
  end

  def create
    @handle_from_path = params.fetch("query_challenge_id") # this works, but it gives the handle, not id
    challenge_id = Challenge.where({ :challenge_handle => @handle_from_path}).at(0).id

    the_photoworkout = Photoworkout.new
    the_photoworkout.caption = params.fetch("query_caption")
    the_photoworkout.challenge_id = challenge_id
    the_photoworkout.user_id = params.fetch("query_user_id")
    the_photoworkout.likes_count = 0
    the_photoworkout.photo_locator = params.fetch("query_photo_locator")
    the_photoworkout.calories = params.fetch("query_calories")
    the_photoworkout.main_exercise = params.fetch("query_main_exercise")

    
    if the_photoworkout.valid?
      the_photoworkout.save
      handle = the_photoworkout.challenge.challenge_handle
      redirect_to("/challenges/#{handle}", { :notice => "Photoworkout created successfully." })
    else
      redirect_to("/challenges/", { :notice => "Photoworkout failed to create successfully." })
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

    redirect_to("/challenges", { :notice => "Photoworkout deleted successfully."} )
  end

  def like
    handle = params.fetch("handle")

    the_id = params.fetch("path_id")
    the_photoworkout = Photoworkout.where({ :id => the_id }).at(0)

    the_photoworkout.likes_count = the_photoworkout.likes_count + 1
    the_photoworkout.save

    redirect_to("/challenges/#{handle}", { :notice => "You gave power 💪! You can give it again 😜!"} )
  end
end
