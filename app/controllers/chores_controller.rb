class ChoresController < ApplicationController
  swagger_controller :chores, "Chores Management"

  swagger_api :index do
    summary "Fetches all Chores"
    notes "This lists all the Chores"
  end

  swagger_api :show do
    summary "Shows one Chore"
    param :path, :id, :integer, :required, "Chore ID"
    notes "This lists details of one chore"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Chore"
    param :form, :child, :integer, :required, "Child"
    param :form, :task, :integer, :required, "Task"
    param :form, :due_on, :date, :required, "Due on"
    param :form, :completed, :boolean, :required, "Completed"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Chore"
    param :path, :id, :integer, :required, "chore Id"
    param :form, :child, :integer, :required, "Child"
    param :form, :task, :integer, :required, "Task"
    param :form, :due_on, :date, :required, "Due on"
    param :form, :completed, :boolean, :required, "Completed"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Chore"
    param :path, :id, :integer, :required, "chore Id"
    response :not_found
  end

	before_action :set_chore, only: [:show, :update, :destroy]

  def index
    @chores = Chore.all

    render json: @chores
  end

  def show
    render json: @chore
  end

  def create
    @chore = Chore.new(chore_params)

    if @chore.save
      render json: @chore, status: :created, location: @chore
    else
      render json: @chore.errors, status: :unprocessable_entity
    end
  end

  def update
    if @chore.update(chore_params)
      render json: @chore
    else
      render json: @chore.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @chore.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chore
      @chore = Chore.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chore_params
      params.permit(:child, :task, :due_on, :completed)
    end
end

