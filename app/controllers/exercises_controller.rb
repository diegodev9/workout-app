class ExercisesController < ApplicationController
  before_action :set_exercise, only: :show

  def index
  end

  def new
    @exercise = current_user.exercises.build
  end

  def show

  end

  def create
    @exercise = current_user.exercises.build(exercise_params)
    puts params

    if @exercise.save
      redirect_to user_exercise_path(current_user, @exercise), notice: 'Exercise has been created'
    else
      render :new
    end
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:workout, :duration_in_min, :workout_date, :user_id)
  end
end