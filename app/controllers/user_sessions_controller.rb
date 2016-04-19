class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy, :edit]
  before_action :require_unauthenticated, except: [:destroy, :edit]

  def new
    @user = User.new
  end

  def edit
  end

  def create
    if @user = login(params[:username], params[:password])
      redirect_back_or_to(:users, notice: 'Login successful')
    else
      flash.now[:error] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end

  private

  def require_unauthenticated
    redirect_to logout_path, notice: "Already logged in" if logged_in?
  end
end
