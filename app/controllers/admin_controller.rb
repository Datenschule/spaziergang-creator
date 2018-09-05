class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @users = User.all
    @walks = Walk.all
  end

  private

  def ensure_admin
    render_403 unless current_user.present? && current_user.admin?
  end
end
