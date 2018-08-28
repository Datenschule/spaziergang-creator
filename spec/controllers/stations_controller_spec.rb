require 'rails_helper'

RSpec.describe StationsController, type: :controller do
  describe 'Stations' do
    describe 'GET stations#index' do
      pending 'should render stations#index'
    end

    describe 'GET stations#new' do
      pending 'should render stations#new'
    end

    describe 'GET stations#edit' do
      pending 'should render stations#edit'
    end

    describe 'POST stations#create' do
      context 'with valid attributes' do
        pending 'should save the station in the database'
        pending 'should redirect to station#show'
      end

      context 'with invalid attributes' do
        pending 'should not save the station in the database'
        pending 'should render station#new template'
      end
    end

    describe 'PUT station#update' do
      pending 'should update an existing station'
    end

    describe 'DELETE station#destroy' do
      pending 'should delete a station'
    end
  end
end
