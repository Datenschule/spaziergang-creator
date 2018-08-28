require 'rails_helper'

RSpec.describe WalksController, type: :controller do
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
    let!(:user) { create(:user) }
    let!(:walks) { create_list(:walk, 3, user: user, public: false) }

    context 'user is logged in' do
      it 'should render template' do
        sign_in user
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
      it 'should redirect to #private' do
        post :create, params: { locale: :de, user: user,
                                walk: { name: 'foo',
                                        description: 'barbaz',
                                        location: 'a city' }}
        expect(response).to be_redirect
      end
    end

    context 'width invalid attributes' do
      pending 'should render new template' do
        post :create, params: { locale: :de, user: user,
                                walk: { name: 'foo'}}
        expect(response).to_not be_redirect
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    let(:user) { create(:user) }
    let(:walk) { create(:walk, name: 'Testwalk', user: user) }
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
    let(:walk) { create(:walk, name: 'Testwalk', user: user) }
    before do
      allow(controller).to receive :authenticate_user!
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'should redirect to private_walks_path' do
      delete :destroy, params: { locale: :de, id: walk.id }
      expect(response).to be_redirect
      expect(response.location).to match private_walks_path
    end
  end
end
