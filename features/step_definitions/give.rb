Given(/^Default data$/) do
  User.create!(
    email: 'user@example.com',
    password: '12345678',
    password_confirmation: '12345678') if User.find_by_email('user@example.com').nil?
end

Given(/^I visit the login view$/) do
  visit new_user_session_path
end

Given(/^I test the success case$/) do
  ManagerSBIF = SBIFSuccessful
end

