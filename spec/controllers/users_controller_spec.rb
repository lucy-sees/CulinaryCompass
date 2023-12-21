require 'rails_helper'

RSpec.feature 'Users management', type: :feature do
  let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'password') }

  scenario 'User visits users index' do
    visit users_path
    expect(page).to have_content('Users')
  end

  scenario 'User visits user show page' do
    visit user_path(user)
    expect(page).to have_content(user.name)
  end

  scenario 'User updates a user' do
    visit edit_user_path(user)

    fill_in 'Name', with: 'Updated User'
    click_button 'Update User'

    expect(page).to have_content('User was successfully updated.')
    expect(page).to have_content('Updated User')
  end
end
