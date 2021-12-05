Rails.application.routes.draw do

  get("/", { :controller => "homes", :action => "index"})

  # Routes for the Photoworkout resource:

  # CREATE
  post("/insert_photoworkout", { :controller => "photoworkouts", :action => "create" })

  get("/challenges/:handle/new", { :controller => "photoworkouts", :action => "new" })
          
  # READ
  # get("/photoworkouts", { :controller => "photoworkouts", :action => "index" })
  
  get("/photoworkouts/:path_id", { :controller => "photoworkouts", :action => "show" })
  
  get("/photoworkouts/:handle/:path_id/add_like", { :controller => "photoworkouts", :action => "like" })

  # UPDATE
  
  post("/modify_photoworkout/:path_id", { :controller => "photoworkouts", :action => "update" })
  
  # DELETE
  get("/delete_photoworkout/:path_id", { :controller => "photoworkouts", :action => "destroy" })

  #------------------------------

  # Routes for the Privilege resource:

  # CREATE
  get("/challenges/:handle/:user_id/insert_privilege", { :controller => "privileges", :action => "create" })
          
  # READ
  # get("/privileges", { :controller => "privileges", :action => "index" })
  
  # get("/privileges/:path_id", { :controller => "privileges", :action => "show" })
  
  # UPDATE
  # post("/modify_privilege/:path_id", { :controller => "privileges", :action => "update" })
  
  # DELETE
  get("/challenges/:handle/:user_id/delete_privilege", { :controller => "privileges", :action => "destroy" })

  #------------------------------

  # Routes for the Team resource:

  # CREATE
  post("/insert_team", { :controller => "teams", :action => "create" })
          
  # READ
  #get("/teams", { :controller => "teams", :action => "index" })
  
  #get("/teams/:path_id", { :controller => "teams", :action => "show" })
  
  # UPDATE
  
  post("/modify_team/:path_id", { :controller => "teams", :action => "update" })
  
  # DELETE
  #get("/delete_team/:path_id", { :controller => "teams", :action => "destroy" })

  #------------------------------

  # Routes for the Participation resource:

  # CREATE
  get("/challenges/:handle/insert_participation", { :controller => "participations", :action => "create" })
          
  # READ
  # get("/participations", { :controller => "participations", :action => "index" })
  
  # get("/participations/:path_id", { :controller => "participations", :action => "show" })
  
  # UPDATE
  
  post("challenges/:handle/modify_participation/", { :controller => "participations", :action => "update" })
  
  # DELETE
  #get("/delete_participation/:path_id", { :controller => "participations", :action => "destroy" })

  #------------------------------

  # Routes for the Challenge resource:

  # CREATE
  get("/challenges/new", { :controller => "challenges", :action => "new" })


  post("/insert_challenge", { :controller => "challenges", :action => "create" })
          
  # READ
  get("/challenges", { :controller => "challenges", :action => "index" })
  
  get("/challenges/:handle", { :controller => "challenges", :action => "show" })

  get("/challenges/:handle/edit", { :controller => "challenges", :action => "edit" })

  get("/challenges/:handle/invite", { :controller => "challenges", :action => "invite" })

  get("/challenges/:handle/rules", { :controller => "challenges", :action => "rules" })

  get("/challenges/:handle/stats", { :controller => "challenges", :action => "stats" })

  get("/challenges/:handle/join", { :controller => "challenges", :action => "join" })

  get("/challenges/:handle/teams", { :controller => "challenges", :action => "teams" })


  # UPDATE
  
  post("/modify_challenge/:path_id", { :controller => "challenges", :action => "update" })
  
  # DELETE
  get("/delete_challenge/:path_id", { :controller => "challenges", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
  
  # USER PROFILE
  get("/users/:user_handle", { :controller => "user_authentication", :action => "show_profile" })

  #------------------------------

end
