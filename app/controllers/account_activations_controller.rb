class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.active
      log_in user
      flash[:success] = t "alert.acc_activate"
      redirect_to user
    else
      flash[:danger] = t "alert.invalid_active_link"
      redirect_to root_path
    end
  end
end
