class PagesController < ApplicationController
  include PagesHelper
  before_action :authenticate_user!
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_subject

  def index
    @pages = Page.where(subject_id: @subject.id)
  end

  def show
    @challenges = pages_parse_challenges @page.challenges if @page.challenges.present?
    answers = pages_parse_answers(@page.answers)
    @answers = pages_clean_answers(answers) if @page.answers.present?
    @correct_answer = pages_correct_answer_index(answers)
  end

  def new
    @page = Page.new
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

  def destroy
    @page.destroy
    redirect_to subject_path(@subject), notice: 'Page deleted!'
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
