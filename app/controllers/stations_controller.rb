class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @stations = Station.all.select do |s|
      s.walk.user == current_user
    end
  end

  def show
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    @station.user_id = current_user.id
    if @station.save!
      redirect_to station_path(@station), success: 'Station saved!'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @station.update(station_params)
    redirect_to station_path(@station), success: 'Station changed!'
  else
    render action: :edit
  end
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name,
                                    :description,
                                    :lon,
                                    :lat,
                                    :walk_id)
  end
end
