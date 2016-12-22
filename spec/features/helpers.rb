module Helpers

  def sign_up(user)
    visit("/users/new")
    fill_in "name", with: user[:name]
    fill_in "username", with: user[:username]
    fill_in "email", with: user[:email]
    fill_in "password", with: user[:password]
    click_button "Sign up"
  end

end
