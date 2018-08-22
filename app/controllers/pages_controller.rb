class PagesController < ApplicationController
  include PagesHelper
  before_action :authenticate_user!
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_subject, only: [:index, :new, :create]

  include BreadcrumbsHelper

  def index
    @pages = Page.where(subject_id: @subject.id)

    breadcrumb_walk_helper(@page.subject.station.walk)
    breadcrumb_station_helper(@page.subject.station)
    breadcrumb_subject_helper(@page.subject)
    add_breadcrumb t('page.plural'), subject_pages_path(@subject)
  end

  def show
    @challenges = pages_parse_challenges @page.challenges if @page.challenges.present?
    answers = pages_parse_answers(@page.answers)
    @answers = pages_clean_answers(answers) if @page.answers.present?
    @correct_answer = pages_correct_answer_index(answers)

    breadcrumb_walk_helper(@page.subject.station.walk)
    breadcrumb_station_helper(@page.subject.station)
    breadcrumb_subject_helper(@page.subject)
    breadcrumb_page_helper(@page)
  end

  def new
    @page = Page.new

    breadcrumb_walk_helper(@subject.station.walk)
    breadcrumb_station_helper(@subject.station)
    breadcrumb_subject_helper(@subject)
    add_breadcrumb t('page.new'), new_subject_page_path(@subject)
  end

  def create
    @page = Page.new(page_params)
    @page.user_id = current_user.id
    @page.subject_id = @subject.id
    @page.priority = @subject.pages.size + 1
    if @page.save!
      redirect_to subject_path(@subject), notice: t('page.saved')
    else
      render action: :new
    end
  end

  def edit
    breadcrumb_walk_helper(@page.subject.station.walk)
    breadcrumb_station_helper(@page.subject.station)
    breadcrumb_subject_helper(@page.subject)
    breadcrumb_page_helper(@page)
    add_breadcrumb t('page.edit'), edit_page_path(@page)
  end

  def update
    if @page.update(page_params)
      redirect_to page_path(@page), notice: t('page.edited')
    else
      render action: :edit
    end
  end

  def sort
    @subject = Subject.find(params[:subject_id])

    breadcrumb_walk_helper(@subject.station.walk)
    breadcrumb_station_helper(@subject.station)
    breadcrumb_subject_helper(@subject)
    add_breadcrumb t('page.change_order'), sort_subject_pages_path(@subject)
  end


  def update_after_sort
    @updates = params[:data]

    @updates.each_with_index do |v, i|
      page = Page.find(v['id'])
      page.priority = v['pos'].to_i

      if v['pos'].to_i == 0
        page.prev = nil
      else
        page.prev = @updates[i - 1]['pos'].to_i
      end

      if @updates[i + 1].present?
        page.next = @updates[i + 1]['pos'].to_i
      else
        page.next = nil
      end

      page.save
    end
  end

  def destroy
    @page.destroy
    redirect_to subject_path(@subject), notice: t('page.deleted')
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end

  def page_params
    params.require(:page).permit(:name,
                                 :variant,
                                 :subject_id,
                                 :user_id,
                                 :content,
                                 :challenges,
                                 :link,
                                 :question,
                                 :answers)
  end
end
