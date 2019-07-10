class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "alert.send_reset"
      redirect_to root_path
    else
      flash.now[:danger] = t "alert.email_not_found"
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t("alert.pass_not_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t "alert.pass_reseted"
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit :password, :password_confirmation
    end

    def get_user
      @user = User.find_by email: params[:email]
      return if @user
      flash[:danger] = t "user.not_found"
      redirect_back_or root_path
    end

    def valid_user
      return if @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      flash[:danger] = t "user._invalid"
      redirect_back_or new_password_reset_path
    end

    def check_expiration
      return unless @user.password_reset_expired?
      flash[:danger] = t "alert.pass_reset_expired"
      redirect_to new_password_reset_url
    end
end
