require 'rails_helper'

RSpec.feature 'User creates food', type: :feature do
  let(:user) { User.create!(name: 'Test User', email: 'testuser@example.com', password: 'password') }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'successfully' do
    visit new_food_path

    fill_in placeholder: 'Name', with: 'Test Food'
    fill_in placeholder: 'Measurement Unit', with: 'Kg'
    fill_in placeholder: 'Price', with: 10
    fill_in placeholder: 'Quantity', with: 5

    click_button 'Create Food'

    expect(page).to have_content('Food was successfully created!')
    expect(page).to have_content('Test Food')
  end

  scenario 'unsuccessfully due to missing fields' do
    visit new_food_path

    click_button 'Create Food'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Measurement unit can't be blank")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Quantity can't be blank")
  end
end
