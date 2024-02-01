# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show; end
  exit
  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'Задача успешно создана'
      redirect_to @task
    else
      flash.now[:error] = 'Не удалось создать задачу'
      render :new
    end
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Задача успешно обновлена'
      redirect_to @task
    else
      flash.now[:error] = 'Не удалось обновить задачу'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'Задача успешно удалена'
    redirect_to tasks_url
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :creator, :performer, :completed)
  end
end
