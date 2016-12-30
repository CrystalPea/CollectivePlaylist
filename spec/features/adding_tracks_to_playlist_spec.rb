require 'spec_helper'

RSpec.feature "Adding tracks to playlist" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "peaczek@gmail.com",
    password: "Mikocian"
    }
  end

  let(:playlist_1) do {
    title: "Neat Playlist",
    description: "For our awesome party",
    tracks_per_person: 2
  }
  end

  scenario "I want to be able to add a track to the playlist" do
    sign_up(user_1)
    create_playlist(playlist_1)
    track_count = Track.all.count
    click_button "Add track(s)"
    fill_in "artist", with: "Shpongle"
    fill_in "title", with: "Nothing Lasts"
    click_button "Add track(s)"
    expect(Track.all.count).to eq(track_count + 1)
    expect(Playlist.first.tracks.count).to eq 1
    expect(current_path).to eq("/playlists/view")
    expect(page).to have_content("Track has been added to 'Neat Playlist'")

  end
end
