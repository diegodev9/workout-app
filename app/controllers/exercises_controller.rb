class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show edit update destroy]

  def index
    @exercises = current_user.exercises.all

    @data_keys = @exercises.map{|exercise| exercise.workout_date.to_s}
    @data_values = @exercises.map{|exercise| exercise.duration_in_min}
  end

  def new
    @exercise = current_user.exercises.build
  end

  def show

  end

  def edit

  end

  def create
    @exercise = current_user.exercises.build(exercise_params)
    puts params

    if @exercise.save
      redirect_to user_exercise_path(current_user, @exercise), notice: 'Exercise has been created'
    else
      flash[:alert] = 'Exercise has not been created'
      render :new
    end
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to user_exercises_path(current_user, @exercise), notice: 'Exercise has been updated'
    else
      flash[:alert] = "Exercise has not been updated"
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to user_exercises_path(current_user), notice: 'Exercise has been deleted'
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:workout, :duration_in_min, :workout_date, :user_id)
  end
end