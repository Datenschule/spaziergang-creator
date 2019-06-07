class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_station, only: [:new, :create]
  before_action :authenticate_user!
  before_action :is_user_blocked, only: [:create, :update, :delete]
  before_action :ensure_user_rights, only: [:show, :edit, :update, :destroy]

  include BreadcrumbsHelper

  def show
    @pages = Page.where(subject_id: @subject.id)

    breadcrumb_walk_helper(@subject.station.walk)
    breadcrumb_station_helper(@subject.station)
    breadcrumb_subject_helper(@subject)
  end

  def new
    @subject = Subject.new

    breadcrumb_walk_helper(@station.walk)
    breadcrumb_station_helper(@station)
    add_breadcrumb t('subject.new_verb'), new_station_subject_path(@station)
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.user_id = current_user.id
    @subject.station_id = @station.id
    if @subject.save!
      redirect_to subject_path(@subject), notice: t('subject.saved')
    else
      render action: :new
    end
  end

  def edit
    breadcrumb_walk_helper(@subject.station.walk)
    breadcrumb_station_helper(@subject.station)
    breadcrumb_subject_helper(@subject)
    add_breadcrumb t('subject.edit'), edit_subject_path(@subject)
  end

  def update
    if @subject.update(subject_params)
      redirect_to subject_path(@subject), notice: t('subject.edited')
    else
      render action: :edit
    end
  end

  def destroy
    @station = @subject.station
    @subject.destroy
    redirect_to station_path(@station), notice: t('subject.deleted')
  end

  private

  def ensure_user_rights
    render_403 unless current_user == @subject.user || current_user.admin?
  end

  def set_station
    @station = Station.find(params[:station_id])
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name,
                                    :description,
                                    :station_id)
  end
end
