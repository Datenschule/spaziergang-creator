require 'rails_helper'

RSpec.feature 'Order stations', type: :feature do
  context 'when walk has not enough stations' do
    let(:user) { FactoryBot.create(:user) }
    let(:walk) { FactoryBot.create(:walk, user: user) }
    let!(:station) { FactoryBot.create(:station, user: user, walk: walk) }

    scenario 'cannot find order button' do
      sign_in_go_to_walk_page
      expect(page).to have_content(station.name)
      expect(page).to_not have_css('[data-tooltip="Change order"]')
    end
  end

  context 'when walk has enough stations' do
    let(:user) { FactoryBot.create(:user) }
    let(:walk) { FactoryBot.create(:walk, user: user) }
    let!(:stations) { FactoryBot.create_list(:station, 2, user: user, walk: walk) }

    scenario 'can find and click order button' do
      sign_in_go_to_walk_page
      expect(page).to have_css('[data-tooltip="Change order"]', count: 1)
      find('[data-tooltip="Change order"]').click
      expect(page).to have_content I18n.t('station.change_order')
    end
  end

  def sign_in_go_to_walk_page
    sign_in user
    visit "/en/walks/#{walk.id}"
  end
end
