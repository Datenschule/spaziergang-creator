require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe 'GET index' do
    pending 'renders template for admin'
  end

  describe 'GET new' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders new template' do
      get :new, params: { locale: :de, station_id: station.id }
      expect(response).to render_template('new')
      expect(response.body).to match I18n.t('subject.new_verb')
    end
  end

  describe 'GET subject#edit' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station)}
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders edit template' do
      get :edit, params: { locale: :de, id: subject.id }
      expect(response).to render_template('edit')
      expect(response.body).to match I18n.t('subject.edit')
    end
  end

  describe 'POST subjects#create' do
    context 'with valid attributes' do
      let(:user) { create(:user) }
      let(:walk) { create(:walk, user: user) }
      let(:station) { create(:station, user: user, walk: walk) }
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(user)
      end
      it 'saves and redirects to subject path' do
        expect {
          post :create, params: { locale: :de, station_id: station.id,
                                  subject: { name: 'Foo', description: 'barbar'}}
        }.to change { Subject.count }.by 1
        expect(response).to be_redirect
        expect(response.location).to match subject_path Subject.last
        expect(flash[:notice]).to eq I18n.t('subject.saved')
      end
    end

    context 'with invalid attributes' do
      let(:user) { create(:user) }
      let(:walk) { create(:walk, user: user) }
      let(:station) { create(:station, user: user, walk: walk) }
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(user)
      end
      it 'does not save nor redirect' do
        expect {
          post :create, params: { locale: :de, station_id: station.id,
                                  subject: { name: nil, description: nil}}
        }.to_not change { Subject.count }
        expect(response).to_not be_redirect
      end
    end
  end

  describe 'PUT subject#update' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station)}
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'redirects to subject path' do
      put :update, params: { locale: :de, id: subject.id,
                             subject: { name: 'better name'}}
      expect(response).to be_redirect
      expect(response.location).to match subject_path subject
      expect(flash[:notice]).to eq I18n.t('subject.edited')
    end
  end

  describe 'DELETE subject#destroy' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    let(:subject) { create(:subject, user: user, station: station)}
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'redirects to station' do
      delete :destroy, params: { locale: :de, id: subject.id}
      expect(response).to be_redirect
      expect(response.location).to match station_path station.id
      expect(flash[:notice]).to eq I18n.t('subject.deleted')
    end
  end
end
