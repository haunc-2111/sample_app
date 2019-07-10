class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t "alert.post_created"
      redirect_to user_path(current_user)
    else
      @feed_items = []
      flash[:danger] = t "alert.post_error"
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "alert.post_deleted"
    else
      flash[:danger] = t "alert.post_deleted_fail"
    end
    redirect_to request.referrer || root_url
  end

  private
    def micropost_params
      params.require(:micropost).permit :content, :picture
    end
    def correct_user
      @micropost = current_user.microposts.find_by id: params[:id]
      redirect_to root_path if @micropost.blank?
    end
end
