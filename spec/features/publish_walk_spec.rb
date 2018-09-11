# coding: utf-8
require 'rails_helper'

RSpec.feature 'Publish a walk', type: :feature do
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
      expect(page).to have_content I18n.t('walk.publish.cannot')

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:first-of-type.active')
        expect(page).to_not have_selector('.step-item:nth-of-type(3) a:not([disabled])')
        click_link('Station')
      end
      expect(page).to have_content(I18n.t('station.new'))

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
      expect(page).to have_content I18n.t('walk.publish.cannot')

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(2).active')
        expect(page).to have_selector('.step-item:nth-of-type(4) a:not([disabled])')
        expect(page).to_not have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Route')
      end
      expect(page).to have_content(I18n.t('walk.course.label'))
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
      expect(page).to have_content I18n.t('walk.publish.cannot')

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(3).active')
        expect(page).to have_selector('.step-item:nth-of-type(4) a:not([disabled])')
        expect(page).to_not have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Subject')
      end
      expect(page).to have_content(I18n.t('subject.new_verb'))
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
      expect(page).to have_content I18n.t('walk.publish.cannot')

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(4).active')
        expect(page).to have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Page')
      end
      expect(page).to have_content(I18n.t('page.new_verb'))
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
      expect(page).to have_content I18n.t('walk.publish.cannot')

      within '.walk-publish-container' do
        expect(page).to have_selector('.step-item:nth-of-type(4).active')
        expect(page).to have_selector('.step-item:nth-of-type(5) a:not([disabled])')
        click_link('Page')
      end
      expect(page).to have_content(I18n.t('page.new_verb'))
    end
  end

  pending 'with a publishable walk' do
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

    scenario 'click on publish button', js: true do
      sign_in user
      visit "/en/walks/#{walk.id}"
      click_link 'Your walks'
      click_link walk.name
      expect(page).to have_content I18n.t('walk.publish.can')

      within '.walk-publish-container' do
        find('[data-tooltip="Publish walk"]').click
      end
      expect(page).to_not have_content I18n.t('walk.publish.can')
      expect(page).to_not have_selector '.walk-publish-container'
      expect(page).to have_selector '.walk-container span[data-tooltip="public"]'
    end
  end
end
