require 'spec_helper'

RSpec.feature "Log in" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "pea@gmail.com",
    password: "Mikocian"
    }
  end

  scenario "I would like to log in" do
    sign_up(user_1)
    click_link("Log out")
    click_link("Log in")
    expect(current_path).to eq "/sessions/new"
    fill_in "username", with: "pea"
    fill_in "password", with: "Mikocian"
    click_button "Log in"
    expect(current_path).to eq "/"
    message = "Welcome to Collective Playlist, Pea!"
    expect(page).to have_content(message)
  end

  scenario "I should not be able to log in with wrong password" do
    sign_up(user_1)
    click_link("Log out")
    click_link("Log in")
    expect(current_path).to eq "/sessions/new"
    fill_in "username", with: "pea"
    fill_in "password", with: "Mikosan"
    click_button "Log in"
    expect(current_path).to eq "/sessions/new"
    message = "Incorrect username and/or password"
    expect(page).to have_content(message)
  end

  scenario "I should not be able to log in with wrong username" do
    sign_up(user_1)
    click_link("Log out")
    click_link("Log in")
    expect(current_path).to eq "/sessions/new"
    fill_in "username", with: "peaczek"
    fill_in "password", with: "Mikocian"
    click_button "Log in"
    expect(current_path).to eq "/sessions/new"
    message = "Incorrect username and/or password"
    expect(page).to have_content(message)
  end

  scenario "I shouldn't be able to log in with empty username" do
    sign_up(user_1)
    click_link("Log out")
    click_link("Log in")
    expect(current_path).to eq "/sessions/new"
    fill_in "username", with: ""
    fill_in "password", with: "Mikosan"
    click_button "Log in"
    expect(current_path).to eq "/sessions/new"
    message = "Incorrect username and/or password"
    expect(page).to have_content(message)
  end

end
