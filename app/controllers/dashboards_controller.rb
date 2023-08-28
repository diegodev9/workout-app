class DashboardsController < ApplicationController
  def index
    @pagy,@athletes = pagy(User.all)
  end

  def search
    @pagy, @athletes = pagy(User.search_by_name(params[:search_name]))
  end
end