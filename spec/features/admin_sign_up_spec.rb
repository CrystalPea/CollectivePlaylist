require 'spec_helper'

RSpec.feature "Sign up as admin" do
  scenario "I should be able to sign up" do
    user_count = User.all.count
    visit("/users/new")
    fill_in "name", with: "Pea"
    fill_in "username", with: "pea"
    fill_in "email", with: "peaczek@gmail.com"
    fill_in "password", with: "Mikocian86"
    click_button "Sign up"

    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "Welcome to Collective Playlist, #{User.first.name}!"
    expect(User.all.count).to eq(user_count + 1)
  end

  scenario "I shouldn't be able to sign up with incorrect email format" do
    user_count = User.all.count
    visit("/users/new")
    fill_in "name", with: "Pea"
    fill_in "username", with: "pea"
    fill_in "email", with: "peaczek"
    fill_in "password", with: "Mikocian86"
    click_button "Sign up"

    expect(current_path).to eq "/users/new"
    expect(page).to have_content "Email has an invalid format"
    expect(User.all.count).to eq(user_count)
  end

  scenario "I shouldn't be able to sign up with a taken username" do
  end

  scenario "user uses taken email" do
  end

  scenario "password confirmation does not match password" do
  end

  scenario "user uses forbidden special characters" do
  end
end
