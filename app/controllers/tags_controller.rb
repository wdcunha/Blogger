class TagsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def edit

  end

  def destroy
    @tag = Tag.find(params[:id])

    if @tag.destroy
      flash[:notice] = "Tag '#{@tag.name}' Successfully deleted!!"
      redirect_to tags_path
    else
      flash[:alert] = "ERRO DELETING TAG '#{@tag.name}'!!"
    end
  end
end
