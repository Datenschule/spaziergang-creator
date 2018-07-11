# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Walks API', type: :request do
  let!(:user) { create(:user) }
  let!(:walks) { create_list(:walk, 3, user) }
  let(:walk_id) { walks.first.id }

  # Test suite for GET /walks
  describe 'GET /walks' do

    before { get '/walks', headers: {'ACCEPT' => 'application/json'} }

    pending 'returns walks' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    pending 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /walks/:id
  describe 'GET /walks/:id' do
    before { get "/walks/#{walk_id}" }

    context 'when the record exists' do
      pending 'returns the walk' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(walk_id)
      end

      pending 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:walk_id) { 100 }

      pending 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      pending 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Walk/)
      end
    end
  end
end
