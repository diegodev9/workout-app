class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def show
    @friend = Friendship.find(params[:id]).friend.user

    @exercises = @friend.exercises
    puts "#{@friend.id}" "#{@friend.full_name}"
    puts @exercises.count

    @data_keys = @exercises.map{|exercise| exercise.workout_date.to_s}
    @data_values = @exercises.map{|exercise| exercise.duration_in_min}
  end

  def create
    friend = Friend.create(user_id: params[:friend_id])
    params[:user_id] = current_user.id

    Friendship.create(friendship_params) unless current_user.follows_or_same?(friend)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    unfollowed = @friendship.friend.user.full_name
    @friendship.destroy
    redirect_to user_exercises_path(current_user), notice: "#{unfollowed} unfollowed"
  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end