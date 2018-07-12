class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new
    @type_options = Page::TYPES
  end

  def create
    @page = Page.new(page_params)
    @page.challenges = parse_challenges.to_s if page_params[:challenges].present?
    @page.answers = parse_answers.to_s if page_params[:answers].present?
  end

  def edit
  end

  def update
  end

  def destroy
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

  def page_params
    params.require(:page).permit(:name,
                                 :type,
                                 :subject_id,
                                 :user_id,
                                 :content,
                                 :challenges,
                                 :link,
                                 :question,
                                 :answers)
  end
end
