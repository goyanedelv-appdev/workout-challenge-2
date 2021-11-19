class HomesController < ApplicationController

  def index
    render({ :template => "home/home.html.erb" })

  end
end
