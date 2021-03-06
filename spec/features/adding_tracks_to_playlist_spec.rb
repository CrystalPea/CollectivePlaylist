require 'spec_helper'

RSpec.feature "Adding tracks to playlist" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "pea@gmail.com",
    password: "Mikocian"
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

  let(:track_2) do {
    artist: "Ott",
    title: "382 Seaside"
    }
  end

  let(:track_3) do {
    artist: "Rise Against",
    title: "Disparity by design"
    }
  end

  scenario "I want to be able to add a track to the playlist" do
    sign_up(user_1)
    create_playlist(playlist_1)
    track_count = Track.all.count
    add_track(track_1)
    expect(Track.all.count).to eq(track_count + 1)
    expect(Playlist.first.tracks.count).to eq 1
    expect(current_path).to eq("/playlists/user")
    expect(page).to have_content("Track has been added to 'Neat Playlist'")
  end

  scenario "I want to see how many more tracks I can add" do
    sign_up(user_1)
    create_playlist(playlist_1)
    expect(page).to have_content("You can add 2 more track(s)")
    add_track(track_1)
    expect(page).to have_content("You can add 1 more track(s)")
  end

  scenario "I shouldn't be able to add more tracks than my allowance" do
    sign_up(user_1)
    create_playlist(playlist_1)
    add_track(track_1)
    add_track(track_2)
    expect(page).not_to have_button("Add track(s)")
    track_count = Track.all.count
    visit "/tracks/new"
    expect(current_path).to eq "/"
    expect(page).to have_content "Something went wrong"

  end

  scenario "I should not be able to add a track with an empty field" do
    sign_up(user_1)
    create_playlist(playlist_1)
    click_button "Add track(s)"
    fill_in "artist", with: ""
    fill_in "title", with: ""
    click_button "Add track(s)"
    expect(current_path).to eq "/tracks/new"
    expect(page).to have_content "must not be"
  end
end
