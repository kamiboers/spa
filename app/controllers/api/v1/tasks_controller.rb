class Api::V1::TasksController < ApplicationController
  respond_to :json

  def index
    respond_with Task.order(created_at: :desc)
  end

  def show
    respond_with Task.find(params[:id])
  end  

  def create
    task = Task.new(task_params)
    if task.save
      respond_with(task, status: 201, location: api_v1_task_path(task))
    else
      render json: {errors: task.errors}, status: 422 #, location: api_v1_tasks_path
    end
  end
  
  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      respond_with(task, status: 200, location: api_v1_tasks_path(task))
    else
      render json: {errors: task.errors}, status: 422
    end
  end

  def toggle
    task = Task.find(params[:id])
    task.toggle_completion
    if not task.errors
      respond_with(task, status: 200, location: api_v1_task_path(task))
    else
      render json: {errors: task.errors}, status: 422
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    head :no_content
  end


  private
    def task_params
      params.require(:task).permit(:body, :title, :quality)
    end

end
