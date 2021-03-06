class API::V1::WalksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
    @walks = Walk.public_not_blocked
    render "api/walks/index.json", locals: {status: "success" }
  end

  def show
    @walk = Walk.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @walk.public
    raise ActiveRecord::RecordNotFound if @walk.user.blocked
    render "api/walks/show.json", locals: {status: "success"}
  end

  private

  def record_not_found
    render "api/walks/error.json", locals: {status: "error", message: "walk not found"}
  end
end
