require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe 'Subjects' do
    describe 'GET subjects#index' do
      it 'should render subjects#index'
    end

    describe 'GET subjects#new' do
      it 'should render subjects#new'
    end

    describe 'GET subject#edit' do
      it 'should render subject#edit'
    end

    describe 'POST subjects#create' do
      context 'with valid attributes' do
        it 'should save the subject in the database'
        it 'should redirect to subject#show'
      end

      context 'with invalid attributes' do
        it 'should not save the subject in the database'
        it 'should render subject#new template'
      end
    end

    describe 'PUT subject#update' do
      it 'should update an existing subject'
    end

    describe 'DELETE subject#destroy' do
      it 'should delete a subject'
    end
  end
end
