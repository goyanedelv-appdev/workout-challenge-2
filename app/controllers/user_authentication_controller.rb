class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  # skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    # if session.fetch(:user_id) != nil
    #  redirect_to("/")
    # else
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

    q_email = params.fetch("query_email")
    q_username = params.fetch("query_username")

    if User.exists?(email: q_email)
      redirect_to("/user_sign_up", { :alert => "That email already exists. If you forgot your password, well, you are screwed because I didn't programmed a recovery flow 🤣"})
    elsif User.exists?(username: q_username)
      redirect_to("/user_sign_up", { :alert => "That username already exists. Come on, be more creative 🧠"})
    else
      @user = User.new
      @user.email = params.fetch("query_email").downcase
      @user.password = params.fetch("query_password")
      @user.password_confirmation = params.fetch("query_password_confirmation")
      @user.is_premium = false # params.fetch("query_is_premium", false)
      
      @user.profile_picture = params.fetch("query_profile_picture")
      
      @user.profile_picture = "/assets/images/default_image.jpg" if @user.profile_picture.empty?
      
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

  def show_profile
    username = params.fetch("user_handle")
  
    @user = User.where({ :username => username }).at(0)

    if @user == nil
      redirect_to("/challenges", { :alert => "User not found" })
    else

      photoworkouts = Photoworkout.where({:user_id => @user.id})
      @q_wkt = photoworkouts.count

      @level = "Tiny penguin"

      if @q_wkt < 10
        @level = "Tiny penguin 🐧"
        
      elsif @q_wkt < 20
        @level = "Small otter 🦦"
      elsif @q_wkt < 50
        @level = "Growing llama 🦙"
      elsif @q_wkt < 100
        @level = "Big gorilla 🦍"
      elsif @q_wkt < 200
        @level = "Great tiger 🐆"
      else
        @level = "Beast 🐉"
      end

      render({ :template => "user_authentication/show_profile.html.erb" })
    end
  end
 
end
