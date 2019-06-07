class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_rights
  before_action :set_user

  def update
    handle_admin_flag
    handle_blocked_flag
    if @user.save!
      redirect_to admin_index_path(anchor: 'users'),
                  notice: "#{@user.email} #{t('user.saved')}!"
    else
      redirect_to admin_index_path(anchor: 'users'),
                  error: "#{@user.email} #{t('user.not_saved')}!"
    end
  end

  def destroy
    u = @user
    @user.destroy
    redirect_to admin_index_path(anchor: 'users'),
                notice: "#{u.email} #{t('admin.deleted')}!"
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :admin,
                                 :blocked)
  end

  def ensure_user_rights
    render_403 unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def handle_blocked_flag
    return unless user_params[:blocked].present?
    @user.blocked = user_params[:blocked] == 'true'
  end

  def handle_admin_flag
    return unless user_params[:admin].present?
    @user.admin = user_params[:admin] == 'true'
  end
end
