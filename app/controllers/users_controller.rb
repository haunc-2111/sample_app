class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)
  before_action :get_user, except: %i(index new create)
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated.page(params[:page]).per Settings.users_per_page
  end

  def new
    @user = User.new
  end

  def show
    redirect_to root_path unless @user.activated?
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      log_in @user
      flash[:info] = t "mailer.activation.home_info"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "alert.profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "alert.user_del"
    else
      flash[:danger] = t "alert.user_del_fail"
    end
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t "alert.require_login"
      redirect_to login_url
    end

    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to root_path unless current_user?(@user)
    end

    def get_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = t "user.not_found"
      redirect_back_or root_path
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
