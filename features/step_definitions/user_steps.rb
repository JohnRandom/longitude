Given /^an anonymous user$/ do
  visit '/log_out'
end

Given /^a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create! email: email, password: password, password_confirmation: password
end
