require 'rails_helper'

RSpec.describe WalksController, type: :controller do
  describe 'Walks' do
    describe 'GET walks#index' do
      let!(:user) { create(:user) }
      let!(:walks) { create_list(:walk, 3, user: user, public: true) }

      context 'when the user is logged in' do
        it 'should render walks#index' do
          sign_in user
          visit walks_path
          walks.each do |w|
            expect(page).to have_content(w.name)
          end

          # somehow test edit button
        end
      end

      context 'when the user is not logged in' do
        it 'should render walks#index' do
          visit walks_path
          walks.each do |w|
            expect(page).to have_content(w.name)
          end
          # test non-existence of edit button
        end
      end
    end

    describe 'GET walks#private' do
      context 'when the user is logged in' do
        pending 'should render walks#private'
      end

      context 'when the user is not logged in' do
        pending 'should redirect to walks#index'
      end
    end

    describe 'GET walks#new' do
      context 'when the user is logged in' do
        pending 'should render walks#new'
      end

      context 'when the user is not logged in' do
        pending 'should redirect to walks#index'
      end
    end

    describe 'POST walks#create' do
      context 'width valid attributes' do
        pending 'should save the new walk in the database'
        pending 'should redirect to walks#private'
      end

      context 'width invalid attributes' do
        pending 'should not save the walk in the database'
        pending 'should render walks#new template'
      end
    end

    describe 'PUT walks#update' do
      pending 'should update an existing walk'
    end

    describe 'DELETE walks#destroy' do
      pending 'should delete a walk'
    end
  end
end
