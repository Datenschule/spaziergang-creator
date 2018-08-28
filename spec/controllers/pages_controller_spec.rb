require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET index' do
    pending 'renders template for admin'
  end

  describe 'GET show' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station) }
    let(:page) { create(:page, user: user, subject: subject) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders the show template' do
      get :show, params: { locale: :de, id: page.id }
      expect(response).to render_template('show')
      expect(response.body).to match Page.last.name
    end
  end

  describe 'GET new' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders the new template' do
      get :new, params: { locale: :de, subject_id: subject.id }
      expect(response).to render_template('new')
      expect(response.body).to match I18n.t('page.new')
    end
  end

  describe 'GET edit' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station) }
    let(:page) { create(:page, user: user, subject: subject) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders the edit template' do
      get :edit, params: { locale: :de, id: page.id }
      expect(response).to render_template('edit')
      expect(response.body).to match Page.last.name
      expect(response.body).to match I18n.t('page.edit')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      let(:user) { create(:user) }
      let(:walk) { create(:walk, user: user) }
      let(:station) { create(:station, user: user, walk: walk) }
      let(:subject) { create(:subject, user: user, station: station) }
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(user)
      end
      it 'redirects to page show' do
        post :create, params: { locale: :de, subject_id: subject.id,
                                page: { name: 'Foo page', variant: 'story', content: 'Yeah yeah'}}
        expect(response).to be_redirect
        expect(response.location).to match page_path Page.last
        expect(flash[:notice]).to eq I18n.t('page.saved')
      end
    end

    context 'with invalid params' do
      pending 'does not redirect'
    end
  end

  describe 'PUT update' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station)}
    let(:page) { create(:page, user: user, subject: subject)}
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'redirects to page show' do
      put :update, params: { locale: :de, id: page.id, page: { name: "Better name" } }
      expect(response).to be_redirect
      expect(response.location).to match page_path page.id
      expect(flash[:notice]).to eq I18n.t('page.edited')
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station) }
    let(:page) { create(:page, user: user, subject: subject) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'redirects to subject show' do
      delete :destroy, params: { locale: :de, id: page.id }
      expect(response).to be_redirect
      expect(response.location).to match subject_path subject.id
      expect(flash[:notice]).to eq I18n.t('page.deleted')
    end
  end

  describe 'GET sort' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station) }
    let(:pages) { create_list(:page, 3, user: user, subject: subject) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders sort template' do
      get :sort, params: { locale: :de, subject_id: subject.id }
      expect(response).to render_template('sort')
      expect(response.body).to match I18n.t('page.change_order')
    end
  end

  describe 'PUT update_after_sort' do
    pending 'prev and next logic'
  end
end
