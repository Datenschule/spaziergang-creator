require 'rails_helper'

RSpec.describe StationsController, type: :controller do
  describe 'GET index' do
    pending 'shows all stations for admins'
  end

  describe 'GET show' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'renders show template' do
      get :show, params: { locale: :de, user_id: user.id, id: station.id }
      expect(response).to render_template('show')
      expect(response.body).to match station.name
    end
  end

  describe 'GET new' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders the new template' do
      get :new, params: { locale: :de, walk_id: walk.id }
      expect(response).to render_template('new')
      expect(response.body).to match I18n.t('station.new_verb')
    end
  end

  describe 'POST create' do
    let!(:user) { create(:user) }
    let!(:walk) { create(:walk, user: user) }
    let!(:params) {{ locale: :de, walk_id: walk.id,
                     user_id: user.id,
                     station: { name: 'foo', description: 'barbaz',
                                lat: 0.0, lon: 0.0 }}}
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    context 'with valid attributes' do
      it 'should save and redirect' do
        expect do
          post :create, params: params
        end.to change{ Station.count }.by(1)
        expect(response).to be_redirect
        expect(response.location).to match station_path Station.last
        expect(flash[:notice]).to match I18n.t('station.saved')
      end
    end

    context 'with invalid attributes' do
      it 'should not save the station' do
        expect {
          post :create, params: {locale: :de, user: user,
                                 walk_id: walk.id, station: {foo: 'bar'}}
        }.to_not change { Station.count }
        expect(response).to_not be_redirect
      end
    end
  end

  describe 'GET edit' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'should render edit template' do
      get :edit, params: { locale: :de, id: station.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'should redirect to station' do
      put :update, params: { locale: :de, id: station.id, station: { name: 'New name' } }
      expect(response).to be_redirect
      expect(response.location).to match station_path station.id
      expect(flash[:notice]).to eq I18n.t('station.edited')
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let!(:station) { create(:station, user: user, walk: walk) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'redirects to walk' do
      expect {
        delete :destroy, params: { locale: :de, id: station.id }
      }.to change { Station.count }.by(-1)
      expect(response).to be_redirect
      expect(response.location).to match walk_path walk
    end
  end

  describe 'GET sort' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:station) { create(:station, user: user, walk: walk) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders the sort template' do
      get :sort, params: { locale: :de, walk_id: walk.id}
      expect(response).to render_template('sort')
    end
  end

  describe 'PUT update_after_sort' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, user: user) }
    let(:stations) { create_list(:station, 3, user: user, walk: walk) }
    let(:data) {{ locale: :de,
                  walk_id: walk.id,
                  station: {},
                  data: [{ id: stations[0].id, pos: 2 },
                         { id: stations[1].id, pos: 0 },
                         { id: stations[2].id, pos: 1 }] }}
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'saves station priorities' do
      put :update_after_sort, params: data
      expect(response).to_not be_redirect
      expect(response.status).to be 204
    end
  end
end
