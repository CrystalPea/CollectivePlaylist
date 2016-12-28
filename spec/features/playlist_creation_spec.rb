require 'spec_helper'

RSpec.feature "Playlist creation" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "peaczek@gmail.com",
    password: "Mikocian"
    }
  end

  scenario "I want to create a playlist" do
    playlist_count = Playlist.all.count
    sign_up(user_1)
    visit "/playlists/new"
    fill_in 'title', with: "Neat Playlist"
    fill_in 'description', with: "For our awesome party"
    select 2, from: 'tracks_per_person'
    click_button "Create Playlist"
    expect(current_path).to eq "/playlists/view"
    message = "Your playlist 'Neat Playlist' has been created"
    expect(page).to have_content(message)
    expect(Playlist.all.count).to eq (playlist_count + 1)
  end

  scenario "I should not be able to create a playlist while not logged in" do
    visit "/playlists/new"
    expect(current_path).to eq "/"
    message = "You need to be logged in to add a playlist"
    expect(page).to have_content(message)
  end

  scenario "I need to fill in title to add a playlist" do
    playlist_count = Playlist.all.count
    sign_up(user_1)
    visit "/playlists/new"
    fill_in 'title', with: ""
    fill_in 'description', with: "For our awesome party"
    select 2, from: 'tracks_per_person'
    click_button "Create Playlist"
    expect(current_path).to eq "/playlists/new"
    message = "Title must not be blank"
    expect(page).to have_content(message)
    expect(Playlist.all.count).to eq (playlist_count)
  end

  scenario "I don't need a description to add a playlist" do
    playlist_count = Playlist.all.count
    sign_up(user_1)
    visit "/playlists/new"
    fill_in 'title', with: "Neat Playlist"
    fill_in 'description', with: ""
    select 2, from: 'tracks_per_person'
    click_button "Create Playlist"
    expect(current_path).to eq "/playlists/view"
    message = "Your playlist 'Neat Playlist' has been created"
    expect(page).to have_content(message)
    expect(Playlist.all.count).to eq (playlist_count + 1)
  end
end
