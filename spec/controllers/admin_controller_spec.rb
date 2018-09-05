require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe 'GET index' do
    context 'as normal user' do
      let(:user) { create(:user) }
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(user)
      end
      it 'forbids access' do
        get :index, params: { locale: :de }
        expect(response.status).to eq 403
        expect(response.body).to match '403'
      end
    end

    context 'as admin' do
      let(:admin) { create(:user, admin: true) }
      before do
        allow(controller).to receive :authenticate_user!
        allow(controller).to receive(:current_user).and_return(admin)
      end
      it 'renders template' do
        get :index, params: { locale: :de }
        expect(response).to render_template('admin/index')
        expect(response.body).to match I18n.t('admin.dash')
      end
    end
  end
end
