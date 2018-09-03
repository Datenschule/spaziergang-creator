require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'PATCH update' do
    context 'as normal user' do
      let!(:user) { create(:user) }
      let!(:params) {{ locale: :de, id: user.id, user: { admin: 'true'}}}
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(user)
      end
      it 'forbids access' do
        patch :update, params: params
        expect(response.status).to eq 403
        expect(response.body).to match '403'
      end
    end

    context 'as admin' do
      let!(:admin) { create(:user, admin: true) }
      let!(:user) { create(:user, admin: false) }
      let!(:params) {{ locale: :de, id: user.id, user: { admin: 'true'}}}
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(admin)
      end
      it 'redirects' do
        patch :update, params: params
        expect(response.location).to match admin_index_path
        expect(flash[:notice]).to match user.email
      end
    end
  end
end
