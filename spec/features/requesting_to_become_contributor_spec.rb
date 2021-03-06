require 'spec_helper'

RSpec.feature "Requesting to become a contributor" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "pea@gmail.com",
    password: "Mikocian"
    }
  end

  let(:user_2) do {
    name: "Miko",
    username: "omi",
    email: "omi@gmail.com",
    password: "Peacian"
    }
  end

  let(:playlist_1) do {
    title: "Neat Playlist",
    description: "For our awesome party",
    tracks_per_person: 2
  }
  end

  let(:track_1) do {
    artist: "Shpongle",
    title: "Nothing Lasts"
    }
  end

  scenario "I want to request to become a contributor" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    expect(Request.all.count).to eq 0
    click_button("I want to contribute")
    expect(Request.all.count).to eq 1
    expect(current_path).to eq("/playlists/view")
    message = "Your request has been sent"
    expect(page).to have_content(message)
  end

  scenario "I want to make a request from playlist page" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    click_link("♫ #{Playlist.first.title}")
    expect(Request.all.count).to eq 0
    click_button("I want to contribute")
    expect(Request.all.count).to eq 1
    expect(current_path).to eq("/playlists/view")
    message = "Your request has been sent"
    expect(page).to have_content(message)
  end

  scenario "As an admin I want to approve request" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    click_link("♫ #{Playlist.first.title}")
    click_button("I want to contribute")
    log_out
    log_in(user_1)
    visit("/requests/view")
    click_button("Accept")
    expect(current_path).to eq "/requests/view"
    message = "Miko has been added as Neat Playlist contributor"
    expect(page).to have_content(message)
    expect(Request.first.status).to eq "Accepted"
  end

  scenario "I want to be able to contribute when my request is accepted" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    click_link("♫ #{Playlist.first.title}")
    click_button("I want to contribute")
    log_out
    log_in(user_1)
    visit("/requests/view")
    click_button("Accept")
    log_out
    log_in(user_2)
    visit("/playlists/view")
    add_track(track_1)
    expect(Playlist.first.tracks.count).to eq 1

  end

  scenario "As an admin I want to reject request" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    click_link("♫ #{Playlist.first.title}")
    click_button("I want to contribute")
    log_out
    log_in(user_1)
    visit("/requests/view")
    click_button("Reject")
    expect(current_path).to eq "/requests/view"
    message = "Miko's request has been rejected."
    expect(page).to have_content(message)
    expect(Request.first.status).to eq "Rejected"
  end

  scenario "I want to see if my request has been accepted" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    click_link("♫ #{Playlist.first.title}")
    click_button("I want to contribute")
    log_out
    log_in(user_1)
    visit("/requests/view")
    click_button("Accept")
    log_out
    log_in(user_2)
    visit("/requests/view")
    expect(page).to have_content("Accepted")

  end

  scenario "As an admin I only want to receive one request per playlist per user" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    click_link("♫ #{Playlist.first.title}")
    click_button("I want to contribute")
    expect(page).not_to have_content("I want to contribute")
  end
end
