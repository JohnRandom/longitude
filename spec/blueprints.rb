require 'machinist/active_record'
require 'faker'

User.blueprint do
  email {Faker::Internet.email}
  password {'test'}
  password_confirmation {'test'}
end

Route.blueprint do
  user {User.make!}
  name {"test route"}
#  locations
end

Location.blueprint do
  latitude { 1.0 }
  longitude { 1.0 }
end
