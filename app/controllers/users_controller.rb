class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user, only: %i[ show ]

  def profile
    # you can also preload associations like roadmap_steps or focus_sessions if needed
    @user = current_user
    render :show
  end
end
