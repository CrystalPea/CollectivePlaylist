require 'spec_helper'

RSpec.feature "Sign up as organiser" do

  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "peaczek@gmail.com",
    password: "Mikocian"
    }
  end

  let(:user_2) do {
    name: "Peja",
    username: "pea",
    email: "polaczek@o2.pl",
    password: "BombaPl0mba"
    }
  end

  let(:user_3) do {
    name: "Pola",
    username: "peanee",
    email: "peaczek@gmail.com",
    password: "BombaPl0mba"
    }
  end

  scenario "I should be able to sign up" do
    user_count = User.all.count
    sign_up(user_1)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "Welcome to Collective Playlist, #{User.first.name}!"
    expect(page).not_to have_content "Sign up"
    expect(User.all.count).to eq(user_count + 1)
  end

  scenario "I shouldn't be able to sign up with incorrect email format" do
    user_count = User.all.count
    visit("/users/new")
    fill_in "name", with: "Pea"
    fill_in "username", with: "pea"
    fill_in "email", with: "peaczek"
    fill_in "password", with: "Mikocian"
    fill_in "password_confirmation", with: "Mikocian"
    click_button "Sign up"

    expect(current_path).to eq "/users/new"
    expect(page).to have_content "Email has an invalid format"
    expect(User.all.count).to eq(user_count)
  end

  scenario "I shouldn't be able to sign up with a taken username" do
    user_count = User.all.count
    sign_up(user_1)
    click_link("Log out")
    sign_up(user_2)
    expect(current_path).to eq "/users/new"
    expect(page).to have_content "Username is already taken"
    expect(User.all.count).to eq(user_count + 1)
  end

  scenario "I shouldn't be able to sign up with a taken e-mail address" do
    user_count = User.all.count
    sign_up(user_1)
    click_link("Log out")
    sign_up(user_3)
    expect(current_path).to eq "/users/new"
    expect(page).to have_content "Email is already taken"
    expect(User.all.count).to eq(user_count + 1)
  end

  scenario "password confirmation does not match password" do
    user_count = User.all.count
    visit "/"
    click_link("Sign up")
    fill_in "name", with: user_1[:name]
    fill_in "username", with: user_1[:username]
    fill_in "email", with: user_1[:email]
    fill_in "password", with: user_1[:password]
    fill_in "password_confirmation", with: "BonGlon"
    click_button "Sign up"
    expect(current_path).to eq "/users/new"
    expect(page).to have_content "Password does not match the confirmation"
    expect(User.all.count).to eq(user_count)

  end

  xscenario "user uses forbidden special characters" do
  end

  scenario "I shouldn't be able to sign up with empty fields" do
    user_count = User.all.count
    visit("/users/new")
    fill_in "name", with: ""
    fill_in "username", with: ""
    fill_in "email", with: ""
    fill_in "password", with: ""
    fill_in "password_confirmation", with: ""
    click_button "Sign up"

    expect(current_path).to eq "/users/new"
    expect(page).to have_content "must not be blank"
    expect(User.all.count).to eq(user_count)
  end
end
