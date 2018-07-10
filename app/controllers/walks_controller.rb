# coding: utf-8
class WalksController < ApplicationController
  before_action :set_walk, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @walks = Walk.all

    respond_to do |format|
      format.json { json_response(@walks) }
      format.html { render 'index'}
    end
  end

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    @walk.user = current_user
    if @walk.save!
      redirect_to walks_path, success: 'Walk saved!'
    else
      render action: :new
    end
  end

  def show
    respond_to do |format|
      format.json { json_response(@walk) }
      format.html { render 'show'}
    end
  end

  def edit
  end

  def update
    if @walk.update(walk_params)
      redirect_to walk_path(@walk), success: 'Walk changed!'
    else
      render action: :edit
    end
  end

  def destroy
    @walk.destroy
  end

  private

  def walk_params
    params.require(:walk).permit(:name,
                  :location,
                  :preview_image,
                  :description,
                  :entry,
                  :courseline)
  end

  def set_walk
    @walk = Walk.find(params[:id])
  end
end
