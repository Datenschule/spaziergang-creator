require 'rails_helper'

RSpec.describe StationsController, type: :controller do
  describe 'Stations' do
    describe 'GET stations#index' do
      it 'should render stations#index'
    end

    describe 'GET stations#new' do
      it 'should render stations#new'
    end

    describe 'GET stations#edit' do
      it 'should render stations#index'
    end

    describe 'POST stations#create' do
      context 'with valid attributes' do
        it 'should save the station in the database'
        it 'should redirect to station#show'
      end

      context 'with invalid attributes' do
        it 'should not save the station in the database'
        it 'should render station#new template'
      end
    end

    describe 'PUT station#update' do
      it 'should update an existing station'
    end

    describe 'DELETE station#destroy' do
      it 'should delete a station'
    end

  end
end
