class ArticlesController < ApplicationController
  before_action :require_login, except: [:index,:show]

  include ArticlesHelper
  # Index action to render all articles
  def index
    @articles = Article.all
  end

  # New action for creating article
  def new
    @article = Article.new
    @attachment = Attachment.new
    @attachment.article_id = @article.id
  end

  # Create action saves the article into database
  def create
    @article = Article.new article_params

    if @article.save
      flash[:notice] = "Article '#{@article.title}' Successfully created!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Error creating new article!"
      render :new
    end
  end

  # Edit action retrives the article and renders the edit page
  def edit
     @article = Article.find(params[:id])
     @attachment = Attachment.new
     @attachment.article_id = @article.id
   end

  def update
     @article = Article.find(params[:id])
     if @article.update(article_params)
       flash[:notice] = "Article '#{@article.title}' Updated!"
       redirect_to article_path(@article)
       # redirect_to(:action => 'articles#show')
     else
       render 'edit'
     end
  end

  # The show action renders the individual article after retrieving the the id
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  # The destroy action removes the article permanently from the database
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "Article '#{@article.title}' Successfully deleted!"
      redirect_to articles_path
    else
      flash[:alert] = "Error deleting Article '#{@article.title}'!"
    end
  end

  private

  # def find_article
  #   @article = Article.find(params[:id])
  # end

end
