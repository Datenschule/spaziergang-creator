# coding: utf-8
class WalksController < ApplicationController
  before_action :set_walk, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @walks = Walk.is_public
  end

  def private
    @walks = Walk.where(user_id: current_user.id)
    render 'index'
  end

  def sort_stations
    @walk = Walk.find(params[:walk_id])
  end

  def update_sort_stations
    @walk = Walk.find(params[:walk_id])
    @updates = params[:data]

    @updates.each_with_index do |v, i|
      station = Station.find(v['id'])
      station.priority = v['pos'].to_i
      if @updates[i + 1].present?
        station.next = @updates[i + 1]['pos'].to_i
      else
        station.next = nil
      end
      station.save
    end
  end

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    @walk.user = current_user
    if @walk.save!
      redirect_to private_walks_path, notice: 'Walk saved!'
    else
      render action: :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @walk.update(walk_params)
      redirect_to walk_path(@walk), notice: 'Walk changed!'
    else
      render action: :edit
    end
  end

  def destroy
    @walk.stations.each do |s|
      s.walk_id = 0
      s.save
    end
    @walk.destroy
    redirect_to walks_path, notice: 'Walk deleted!'
  end

  private

  def walk_params
    params.require(:walk).permit(:name,
                  :location,
                  :preview_image,
                  :description,
                  :entry,
                  :courseline,
                  :public)
  end

  def set_walk
    @walk = Walk.find(params[:id])
  end
end
