class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.present?
      current_user.follow @user
      respond_to :js
    else
      flash[:danger] = t "user.not_found"
      redirect_to root_path
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id])
    if relationship.present?
      user = relationship.followed
      current_user.unfollow user
      respond_to :js
    else
      flash[:danger] = t "alert.relation_not_found"
      redirect_to root_path
    end
  end
end
