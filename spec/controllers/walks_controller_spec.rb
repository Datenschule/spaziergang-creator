# coding: utf-8
require 'rails_helper'

RSpec.describe WalksController, type: :controller do
  describe 'protects private user content' do
    context 'as regular user' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:walk) { create(:walk, user: user2)}
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(user1)
      end

      it 'renders 403 when trying to access others content' do
        get :show, params: { locale: :de, id: walk.id }
        expect(response.status).to eq 403
      end
    end

    context 'as admin' do
      let!(:admin) { create(:user, admin: true) }
      let!(:user) { create(:user) }
      let!(:walk) { create(:walk, user: user)}
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(admin)
      end

      it 'allows access' do
        get :show, params: { locale: :de, id: walk.id }
        expect(response).to render_template('show')
      end
    end
  end

  describe 'GET index' do
    context 'user is not logged in' do
      let!(:user) { create(:user) }
      let!(:walks) { create_list(:walk, 3, user: user, public: true) }
      it 'lists public walks' do
        get :index, params: { locale: :de }
        expect(response).to render_template('index')
        walks.each do |w|
          expect(response.body).to match w.name
        end
      end
    end
  end

  describe 'GET private' do
    context 'user is logged in' do
      let!(:user) { create(:user) }
      let!(:walks) { create_list(:walk, 3, user: user, public: false) }
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'should render template' do
        get :private, params: { locale: :de }
        expect(response).to render_template('private_index')
        walks.each do |w|
          expect(response.body).to match w.name
        end
      end
    end

    context 'user is not logged in' do
      it 'should not render template' do
        get :private, params: { locale: :de }
        expect(response).to_not render_template('private_index')
      end
    end
  end

  describe 'GET new' do
    let(:user) { create(:user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'new user has no walks' do
      it 'should redirect to onboarding page' do
        get :new, params: { locale: :de }
        expect(response).to be_redirect
        expect(response.location).to match onboarding_path
      end

      it 'renders when coming from onboarding page' do
        get :new, params: { locale: :de, knows_help_site: 'true' }
        expect(response).to render_template('new')
      end
    end

    context 'user has walks' do
      let!(:walk) { create(:walk, user: user) }
      it 'renders template' do
        get :new, params: { locale: :de }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'width valid attributes' do
      it 'should save walk and redirect to #private' do
        expect {
          post :create, params: { locale: :de, user: user,
                                walk: { name: 'foo',
                                        description: 'barbaz',
                                        location: 'a city' }}
        }.to change { Walk.count }.by 1
        expect(response).to be_redirect
      end
    end

    context 'width invalid attributes' do
      it 'should not save nor redirect' do
        expect { post :create, params: { locale: :de, user: user,
                                         walk: { name: 'foo'}}
        }.to_not change { Walk.count }
        expect(response).to_not be_redirect
      end
    end
  end

  describe 'GET edit' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, name: 'Testwalk', user: user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'renders the edit template' do
      get :edit, params: { locale: :de, id: walk.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    let(:user) { create(:user) }
    let!(:walk) { create(:walk, name: 'Testwalk', user: user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'should redirect to walk path' do
      put :update, params: { locale: :de, id: walk.id,
                             walk: { name: 'A different and better name' }}
      expect(response).to be_redirect
      expect(response.location).to match walk_path walk.id
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let!(:walk) { create(:walk, name: 'Testwalk', user: user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'should redirect to private_walks_path' do
      expect {
        delete :destroy, params: { locale: :de, id: walk.id }
      }.to change { Walk.count }.by -1
      expect(response).to be_redirect
      expect(response.location).to match private_walks_path
    end
  end

  describe 'GET courseline' do
    let(:user) { create(:user) }
    let!(:walk) { create(:walk, name: 'Testwalk', user: user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    context 'walk has less than two stations' do
      it 'redirect to walk path' do
        get :courseline, params: { locale: :de, id: walk.id }
        expect(response).to be_redirect
        expect(response.location).to match walk_path walk.id
      end
    end

    context 'walk has at least two stations and they are sorted' do
      let!(:stations) { create_list(:station, 3, user: user, walk: walk, next: 1) }
      it 'renders the template' do
        get :courseline, params: { locale: :de, id: walk.id }
        expect(response).to render_template('courseline')
      end
    end

    context 'walk has at least two stations but they are not sorted' do
      let!(:stations) { create_list(:station, 3, user: user, walk_id: walk.id) }

      it 'redirects to stations sort' do
        get :courseline, params: { locale: :de, id: walk.id }
        expect(response).to be_redirect
        expect(response.location).to match sort_walk_stations_path walk.id
        expect(flash[:notice]).to eq I18n.t('walk.notice.force_sort')
      end
    end
  end

  describe "PUT save_courseline" do
    let!(:user) { create(:user) }
    let!(:walk) { create(:walk, user: user) }
    let!(:stations) { create_list(:station, 2, user: user, walk: walk)}
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'accepts new courseline' do
      put :save_courseline,
          params: { locale: :de, id: walk.id,
                    walk: {},
                    data: [
                      {id: stations[0].id, coords: [[12, 12], [12, 12]]},
                      {id: stations[1].id, coords: [[12, 12], [12, 12]]}
                    ]}
      expect(response.status).to eq 204
      expect(response).to_not be_redirect
    end
  end
end
