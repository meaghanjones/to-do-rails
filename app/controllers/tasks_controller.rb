class TasksController < ApplicationController
  def edit
    @list = List.find(params[:list_id])
    @task = Task.find(params[:id])
  end

  def new
    @list = List.find(params[:list_id])
    @task = @list.tasks.new
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to list_path(@task.list)
  end

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task successfully added!"
      redirect_to list_path(@task.list)
    else
      render :new
    end
  end

  def update
    @list = List.find(params[:list_id])
    @task= Task.find(params[:id])
    if @task.update(task_params)
      redirect_to list_path(@task.list)
    else
      render :edit
    end
  end

private
  def task_params
    params.require(:task).permit(:description)
  end
end
