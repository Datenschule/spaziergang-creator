class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_station, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @subjects = Subject.all
  end

  def show
    @pages = Page.where(subject_id: @subject.id)

    add_breadcrumb @subject.station.walk.name, walk_path(@subject.station.walk)
    add_breadcrumb @subject.station.name, station_path(@subject.station)
    add_breadcrumb @subject.name, subject_path(@subject)
  end

  def new
    @subject = Subject.new

    add_breadcrumb @station.walk.name, walk_path(@station.walk)
    add_breadcrumb @station.name, station_path(@station)
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
    add_breadcrumb @subject.station.walk.name, walk_path(@subject.station.walk)
    add_breadcrumb @subject.station.name, station_path(@subject.station)
    add_breadcrumb @subject.name, subject_path(@subject)
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
    @subject.destroy
    redirect_to subjects_path, notice: t('subject.deleted')
  end

  private

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
