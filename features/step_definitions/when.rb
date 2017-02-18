When(/^I filled the fields of the login$/) do |data|
  values = data.rows_hash
  within("#new_user") do
    fill_in('user_email', with: values[:email])
    fill_in('user_password', with: values[:password])
  end
end

When /^I visit the main view$/ do
  visit root_path
end

When(/^I click into "(.*?)"$/) do |link|
  click_on(link)
  sleep(3)
end
