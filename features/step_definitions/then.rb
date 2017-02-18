Then(/^I should see in the view "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end