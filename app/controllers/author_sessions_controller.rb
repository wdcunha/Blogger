class AuthorSessionsController < ApplicationController
  before_action :zero_authors_or_authenticated, only: [:new, :create]
  before_action :require_login, except: [:new, :create]

  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(articles_path, notice: 'Logged in successfully!')
    else
      flash.now.alert = "Login failed!!!"
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to(:authors, notice: 'Logged out!')
  end

  def zero_authors_or_authenticated
    # unless Author.count == 0 || current_user
    unless Author.count != 0 || current_user
      redirect_to root_path
      return false
    end
  end
end
