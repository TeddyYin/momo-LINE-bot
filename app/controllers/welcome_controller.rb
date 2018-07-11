class WelcomeController < ApplicationController
  def index
    flash[:notice] = "HI！"
  end
end
