# coding: utf-8
require 'rails_helper'

RSpec.feature 'Publish a walk from walk show', type: :feature do
  context 'with a fresh walk' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:walk) { FactoryBot.create(:walk, user: user) }

    scenario 'click on station link', js: true do
      sign_in user
      visit "/en/walks/#{walk.id}"
      within '.walk-container' do
        expect(page).to have_content(walk.name)
      end
      expect(page).to have_selector('.walk-publish-container')
      expect(page).to have_content "You cannot publish your walk right now."

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:first-of-type.active')
        expect(page).to_not have_selector('.step-item:nth-of-type(3) a:not([disabled])')
        click_link('Station')
      end
      expect(page).to have_content "Create new station"

    end
  end

  context 'with a walk with stations' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:walk) { FactoryBot.create(:walk, user: user) }
    let!(:stations) { FactoryBot.create_list(:station, 2,
                                             user: user,
                                             walk_id: walk.id,
                                             next: 1) }

    scenario 'click on route link', js: true do
      sign_in user
      visit "/en/walks/#{walk.id}"
      expect(page).to have_content "You cannot publish your walk right now."

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(2).active')
        expect(page).to have_selector('.step-item:nth-of-type(4) a:not([disabled])')
        expect(page).to_not have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Route')
      end
      expect(page).to have_content "Set route"
    end
  end

  context 'with a walk with courseline' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:walk) { FactoryBot.create(:walk,
                                    user: user,
                                    courseline: [[12, 12], [12.1, 12]]) }
    let!(:stations) { FactoryBot.create_list(:station, 2,
                                             user: user,
                                             walk_id: walk.id,
                                             next: 1) }

    scenario 'click on subject link', js: true do
      sign_in user
      visit "/en/walks/#{walk.id}"
      expect(page).to have_content "You cannot publish your walk right now."

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(3).active')
        expect(page).to have_selector('.step-item:nth-of-type(4) a:not([disabled])')
        expect(page).to_not have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Subject')
      end
      expect(page).to have_content "Create new subject"
    end
  end

  context 'with a walk with a subject' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:walk) { FactoryBot.create(:walk,
                                    user: user,
                                    courseline: [[12, 12], [12.1, 12]]) }
    let!(:stations) { FactoryBot.create_list(:station, 2,
                                             user: user,
                                             walk_id: walk.id,
                                             next: 1) }
    let!(:subject) { FactoryBot.create(:subject, user: user,
                                       station: stations.first) }

    scenario 'click on page link', js: true do
      sign_in user
      visit "/en/walks/#{walk.id}"
      expect(page).to have_content "You cannot publish your walk right now."

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(4).active')
        expect(page).to have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Page')
      end
      expect(page).to have_content "Create new page"
    end
  end


  context 'with a walk with a subject' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:walk) { FactoryBot.create(:walk,
                                    user: user,
                                    courseline: [[12, 12], [12.1, 12]]) }
    let!(:stations) { FactoryBot.create_list(:station, 2,
                                             user: user,
                                             walk_id: walk.id,
                                             next: 1) }
    let!(:subject) { FactoryBot.create(:subject, user: user,
                                       station: stations.first) }

    scenario 'click on page link', js: true do
      sign_in user
      visit "/en/walks/#{walk.id}"
      expect(page).to have_content "You cannot publish your walk right now."

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(4).active')
        expect(page).to have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Page')
      end
      expect(page).to have_content "Create new page"
    end
  end

  context 'with a publishable walk' do
    let!(:user) { FactoryBot.create(:user, username: 'foobi') }
    let!(:walk) { FactoryBot.create(:walk,
                                    user: user,
                                    courseline: [[12, 12], [12.1, 12]]) }
    let!(:stations) { FactoryBot.create_list(:station, 2,
                                             user: user,
                                             walk_id: walk.id,
                                             next: 1) }
    let!(:subject) { FactoryBot.create(:subject, user: user,
                                       station_id: stations.first.id) }
    let!(:page) { FactoryBot.create(:page, user: user,
                                    subject_id: subject.id) }

    pending 'click on publish button', js: true do
      sign_in user
      visit "/en/walks/#{walk.id}"
      expect(page).to have_content "You cannot publish your walk right now."

      within '.walk-publish-container' do
        find('[data-tooltip="Publish walk"]').click
      end
      expect(page).to_not have_content "You can publish your walk now."
      expect(page).to_not have_selector '.walk-publish-container'
      expect(page).to have_selector '.walk-container span[data-tooltip="public"]'
    end
  end
end
