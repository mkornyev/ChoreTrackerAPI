class TasksController < ApplicationController
  swagger_controller :tasks, "Tasks Management"

  swagger_api :index do
    summary "Fetches all Tasks"
    notes "This lists all the tasks"
  end

  swagger_api :show do
    summary "Shows one task"
    param :path, :id, :integer, :required, "task ID"
    notes "This lists details of one task"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new task"
    param :form, :name, :string, :required, "name"
    param :form, :points, :integer, :required, "points"
    param :form, :active, :boolean, :required, "active"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing task"
    param :path, :id, :integer, :required, "task Id"
    param :form, :name, :string, :required, "name"
    param :form, :points, :integer, :required, "points"
    param :form, :active, :boolean, :required, "active"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing task"
    param :path, :id, :integer, :required, "task Id"
    response :not_found
  end



  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = Task.all

    render json: @tasks
  end

  def show
    render json: @task
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.permit(:name, :points, :active)
    end

end
