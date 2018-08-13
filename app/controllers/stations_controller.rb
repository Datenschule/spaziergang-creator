class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]
  before_action :set_walk, only: [:new, :create, :sort]
  before_action :authenticate_user!

  def index
    @stations = Station.all.select do |s|
      s.walk.user == current_user
    end
  end

  def show
    add_breadcrumb @station.walk.name, walk_path(@station.walk)
    add_breadcrumb @station.name, station_path(@station)
  end

  def new
    @station = Station.new
    add_breadcrumb @walk.name, walk_path(@walk)
    add_breadcrumb t('station.new_verb'), new_walk_station_path(@walk)
  end

  def create
    @station = Station.new(station_params)
    @station.user_id = current_user.id
    @station.walk_id = @walk.id

    @station.priority = @walk.stations.size - 1
    if @station.save!
      redirect_to station_path(@station), notice: t('station.saved')
    else
      render action: :new
    end
  end

  def edit
    add_breadcrumb @station.walk.name, walk_path(@station.walk)
    add_breadcrumb @station.name, station_path(@station)
    add_breadcrumb t('station.edit'), edit_station_path(@station)
  end

  def update
    if @station.update(station_params)
      redirect_to station_path(@station), notice: t('station.edited')
    else
      render action: :edit
    end
  end

  def sort
    add_breadcrumb @walk.name, walk_path(@walk)
    add_breadcrumb t('station.sort.breadcrumb'), sort_walk_stations_path(@walk)
  end

  def update_after_sort
    @updates = params[:data]

    @updates.each_with_index do |v, i|
      station = Station.find(v['id'])
      station.priority = v['pos'].to_i
      station.next = set_station_next(i)
      station.save
    end
  end

  def destroy
    @walk = @station.walk
    @station.destroy
    redirect_to walk_path(@walk), notice: t('station.deleted')
  end

  private

  def set_station_next(i)
    @updates[i + 1]['pos'].to_i if @updates[i + 1].present?
  end

  def set_walk
    @walk = Walk.find(params[:walk_id])
  end

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
