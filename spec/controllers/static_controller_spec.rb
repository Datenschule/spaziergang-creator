require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  describe 'GET index' do
    it 'renders index template' do
      get :index, params: { locale: :de }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET onboarding' do
    it 'renders onboarding template' do
      get :onboarding, params: { locale: :de }
      expect(response).to render_template(:onboarding)
    end
  end

  describe 'GET impressum' do
    it 'renders impressum template' do
      get :impressum, params: { locale: :de }
      expect(response).to render_template(:impressum)
    end
  end

  describe 'GET data_protection' do
    it 'renders data_protection template' do
      get :data_protection, params: { locale: :de }
      expect(response).to render_template(:data_protection)
    end
  end
end
