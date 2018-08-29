require 'rails_helper'

RSpec.describe API::V1::WalksController, type: :controller do
  describe 'GET index' do
    let(:user) { create(:user) }
    let!(:walks) { create_list(:walk, 3, user: user, public: true) }
    let!(:private_walk) { create(:walk, user: user, name: "Private name") }
    it 'renders json with success message' do
      get :index
      expect(response).to render_template('api/walks/index.json')
      walks.each do |w|
        expect(response.body).to include w.name
      end
      expect(response.body).to_not match private_walk.name
      expect(response.body).to match 'success'
      expect(response.status).to be 200
    end
  end

  describe 'GET show' do
    context 'of an existing walk' do
      let(:user) { create(:user) }
      let(:walk) { create(:walk, user: user, public: true) }
      let(:station) { create(:station, user: user, walk: walk)}
      let(:subject) { create(:subject, user: user, station: station)}
      let!(:page) { create(:page, user: user, subject: subject)}
      it 'renders json with success message' do
        get :show, params: { id: walk.id }
        expect(response).to render_template('api/walks/show.json')
        expect(response.body).to match 'success'
        payload = JSON.parse(response.body)
        expect(payload['data']['walk']['name']).to eq walk.name
        expect(payload['data']['walk']['stations'][0]['name']).to eq station.name
        expect(payload['data']['walk']['stations'][0]['subjects'][0]['name']).to eq subject.name
      end
    end

    context 'of a non-existing walk' do
      it 'renders an error message' do
        get :show, params: { id: 7 }
        expect(response).to render_template('api/walks/error.json')
        expect(response.body).to match 'walk not found'
      end
    end
  end
end
