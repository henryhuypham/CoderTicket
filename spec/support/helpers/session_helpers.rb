module Features
  module SessionHelpers
    def sign_up_with(name, email, password)
      visit sign_up_path
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign up'
    end

    def signin(email, password)
      visit login_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
