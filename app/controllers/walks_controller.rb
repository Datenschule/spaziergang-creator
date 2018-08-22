# coding: utf-8
class WalksController < ApplicationController
  before_action :set_walk, only: [:show,
                                  :edit,
                                  :update,
                                  :destroy,
                                  :courseline,
                                  :save_courseline]
  before_action :authenticate_user!, except: [:index]
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

    data.each do |station|
      st = Station.find(station['id'].to_i)
      st.line = station['priority'].to_i - 1
      st.line = '[]' if station['priority'] == '0'
      st.save
    end
  end

  def new
    @walk = Walk.new
    add_breadcrumb t('walk.new'), new_walk_path
  end

  def create
    @walk = Walk.new(walk_params)
    @walk.user = current_user
    if @walk.save!
      redirect_to walk_path(@walk), notice: t('walk.save_success')
    else
      render action: :new
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
    @walk.stations.each do |s|
      s.walk_id = 0
      s.save
    end
    @walk.destroy
    redirect_to private_walks_path, notice: t('walk.deleted')
  end

  private

  def force_sort
    return true if @walk.stations.first.next.present?
    redirect_to sort_walk_stations_path(@walk), notice: t('walk.notice.force_sort')
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
