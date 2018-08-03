class CommentsController < ApplicationController
  before_action :require_login, except: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]

    if @comment.save
      flash[:notice] = "Comment '#{@comment.author_name}' Successfully created!"
      redirect_to article_path(@comment.article)
    else
      flash[:alert] = "Error creating new comment!"
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end

end
