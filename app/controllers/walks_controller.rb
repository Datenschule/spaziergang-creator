# coding: utf-8
class WalksController < ApplicationController
  before_action :set_walk, only: [:show,
                                  :edit,
                                  :update,
                                  :destroy,
                                  :courseline,
                                  :save_courseline]
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_station_length, only: [:courseline]
  before_action :force_sort, only: [:courseline]

  include BreadcrumbsHelper

  def index
    @walks = Walk.is_public
  end

  def private
    @walks = Walk.where(user_id: current_user.id)
    render 'private_index'
  end

  def courseline
    breadcrumb_walk_helper(@walk)
    add_breadcrumb t('walk.course.label'), route_walk_path(@walk)
  end

  def save_courseline
    data = params.to_unsafe_h['data']
    courseline = data.map { |d| d['coords'] }
    @walk.courseline = courseline
    @walk.save
    save_station_order data
  end

  def new
    redirect_to onboarding_path if needs_onboarding_page
    @walk = Walk.new
    add_breadcrumb t('walk.new'), new_walk_path
  end

  def create
    @walk = Walk.new(walk_params)
    @walk.user = current_user
    if @walk.save!
      redirect_to walk_path(@walk), notice: t('walk.save_success')
    else
      render :new, format: :html
    end
  end

  def show
    breadcrumb_walk_helper(@walk)
  end

  def edit
    breadcrumb_walk_helper(@walk)
    add_breadcrumb t('walk.edit'), edit_walk_path(@walk)
  end

  def update
    if @walk.update(walk_params)
      redirect_to walk_path(@walk), notice: t('walk.edited')
    else
      render action: :edit
    end
  end

  def destroy
    @walk.destroy
    redirect_to private_walks_path, notice: t('walk.deleted')
  end

  private

  def save_station_order(stations)
    stations.each do |station|
      st = Station.find(station['id'].to_i)
      st.line = station['priority'].to_i - 1
      st.line = '[]' if station['priority'] == '0'
      st.save
    end
  end

  def needs_onboarding_page
    return false if params[:knows_help_site] == "true"
    current_user.walks.empty?
  end

  def ensure_station_length
    return true if @walk.stations.length > 1
    redirect_to walk_path(@walk) and return
  end

  def force_sort
    @stations = @walk.stations
    return true if @stations.first.present? && @stations.first.next.present?
    redirect_to sort_walk_stations_path(@walk), notice: t('walk.notice.force_sort') and return
  end

  def walk_params
    params.require(:walk).permit(:name,
                  :location,
                  :preview_image,
                  :description,
                  :entry,
                  :courseline,
                  :public,
                  :data)
  end

  def set_walk
    @walk = Walk.find(params[:id])
  end
end
