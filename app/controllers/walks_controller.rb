# coding: utf-8
class WalksController < ApplicationController
  before_action :set_walk, only: [:show, :edit, :update, :destroy]

  def index
    @walks = Walk.all

    respond_to do |format|
      format.json { json_response(@walks) }
      format.html { render 'index'}
    end
    respond_to :html, :json
  end

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    if @walk.save!
      redirect_to walks_path, notice: 'Walk saved!'
    else
      render action: :new
    end
  end

  def show
    json_response(@walk)
    respond_to :html, :json
  end

  def edit
  end

  def update
    @todo.update(walk_params)
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
