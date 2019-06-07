class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]
  before_action :set_walk, only: [:new, :create, :sort]
  before_action :authenticate_user!
  before_action :is_user_blocked, only: [:create,
                                         :update,
                                         :delete,
                                         :sort,
                                         :update_after_sort]
  before_action :ensure_user_rights, only: [:show, :edit, :update, :destroy]

  include BreadcrumbsHelper

  def show
    breadcrumb_walk_helper(@station.walk)
    breadcrumb_station_helper(@station)
  end

  def new
    @station = Station.new
    breadcrumb_walk_helper(@walk)
    add_breadcrumb t('station.new_verb'), new_walk_station_path(@walk)
  end

  def create
    @station = Station.new(station_params)
    @station.user_id = current_user.id
    @station.walk_id = @walk.id
    @station.priority = @walk.next_station_priority

    if @station.save!
      @walk.set_next_on_collection!(@walk.stations) if @station.priority > 0
      redirect_to station_path(@station), notice: t('station.saved')
    else
      render action: :new
    end
  end

  def edit
    breadcrumb_walk_helper(@station.walk)
    breadcrumb_station_helper(@station)
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
    breadcrumb_walk_helper(@walk)
    add_breadcrumb t('station.sort.breadcrumb'), sort_walk_stations_path(@walk)
  end

  def update_after_sort
    updates = params[:data]
    updates.each_with_index do |v, i|
      station = Station.find(v['id'])
      station.priority = v['pos'].to_i
      station.set_next updates.size

      if station.save!
        head :ok
      else
        head :forbidden
      end
    end
  end

  def destroy
    @walk = @station.walk
    @station.destroy
    redirect_to walk_path(@walk), notice: t('station.deleted')
  end

  private

  def ensure_user_rights
    render_403 unless current_user == @station.user || current_user.admin?
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
                                    :walk_id,
                                    :data)
  end
end
