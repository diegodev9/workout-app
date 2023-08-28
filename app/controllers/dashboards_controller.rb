class DashboardsController < ApplicationController
  def index
    @pagy,@athletes = pagy(User.all)
  end
end