class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_subject

  def index
    @pages = Page.where(subject_id: @subject.id)
  end

  def show
    @challenges = @page.challenges.split('-').select { |f| !f.empty? } if @page.challenges.present?
    @answers = @page.answers.split('-').select { |a| !a.empty? }.map { |d| d.split('*')} if @page.answers.present?
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    @page.challenges = parse_challenges.to_s if page_params[:challenges].present?
    @page.answers = parse_answers.to_s if page_params[:answers].present?
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

  def parse_challenges
    page_params[:challenges]
      .split('-')
      .select { |f| !f.empty? }
      .map { |f| f.strip }
  end

  def parse_answers
    page_params[:answers]
      .split('-')
      .select { |f| !f.empty? }
      .map { |f| f.strip }
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
