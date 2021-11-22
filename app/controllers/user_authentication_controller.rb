class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  # skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/challenges", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form

    if session[:user_id] 
      redirect_to("/challenges", { :notice => "You already have an account 💪" })
    else
    render({ :template => "user_authentication/sign_up.html.erb" })
    end
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.is_premium = false # params.fetch("query_is_premium", false)
    @user.profile_picture = params.fetch("query_profile_picture")
    @user.bio = params.fetch("query_bio")
    @user.username = params.fetch("query_username")
 
    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/challenges", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.is_premium = false # initialize as false

    if params.has_key?("query_profile_picture")

      @user.profile_picture =  params.fetch("query_profile_picture") 
    #else
    #  @user.profile_picture = @current_user.profile_picture
    end
    @user.bio = params.fetch("query_bio")
    @user.username = params.fetch("query_username")
    
    if @user.valid?
      @user.save

      redirect_to("/challenges", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end
 
end
