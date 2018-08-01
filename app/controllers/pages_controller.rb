class PagesController < ApplicationController
  include PagesHelper
  before_action :authenticate_user!
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_subject, only: [:index, :new, :create]

  def index
    @pages = Page.where(subject_id: @subject.id)

    add_breadcrumb "All walks", walks_path
    add_breadcrumb @subject.station.walk.name, walk_path(@subject.station.walk)
    add_breadcrumb @subject.station.name, station_path(@subject.station)
    add_breadcrumb @subject.name, subject_path(@subject)
    add_breadcrumb "All Pages", subject_pages_path(@subject)
  end

  def show
    @challenges = pages_parse_challenges @page.challenges if @page.challenges.present?
    answers = pages_parse_answers(@page.answers)
    @answers = pages_clean_answers(answers) if @page.answers.present?
    @correct_answer = pages_correct_answer_index(answers)

    prep_breadcrumb
    add_breadcrumb @page.name, page_path(@page)
  end

  def new
    @page = Page.new

    add_breadcrumb "All walks", walks_path
    add_breadcrumb @subject.station.walk.name, walk_path(@subject.station.walk)
    add_breadcrumb @subject.station.name, station_path(@subject.station)
    add_breadcrumb @subject.name, subject_path(@subject)
    add_breadcrumb "New Page", new_subject_page_path(@subject)
  end

  def create
    @page = Page.new(page_params)
    @page.user_id = current_user.id
    @page.subject_id = @subject.id
    if @page.save!
      redirect_to subject_pages_path(@subject), notice: 'Page saved!'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to subject_page_path(@subject, @page), notice: 'Page changed!'
    else
      render action: :edit
    end
  end

  def sort
    @subject = Subject.find(params[:subject_id])

    add_breadcrumb "All walks", walks_path
    add_breadcrumb @subject.station.walk.name, walk_path(@subject.station.walk)
    add_breadcrumb @subject.station.name, station_path(@subject.station)
    add_breadcrumb @subject.name, subject_path(@subject)
    add_breadcrumb "Sort Pages", sort_subject_pages_path(@subject)
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
    redirect_to subject_path(@subject), notice: 'Page deleted!'
  end

  private

  def prep_breadcrumb
    add_breadcrumb "All walks", walks_path
    add_breadcrumb @page.subject.station.walk.name, walk_path(@page.subject.station.walk)
    add_breadcrumb @page.subject.station.name, station_path(@page.subject.station)
    add_breadcrumb @page.subject.name, subject_path(@page.subject)
  end
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
