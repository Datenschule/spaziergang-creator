class API::V1::WalksController < ApplicationController
  def index
    @walks = Walk.all
    render :json => @walks
  end

  def show
    @walk = Walk.find(params[:id])
  end
end
