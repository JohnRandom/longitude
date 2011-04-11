require 'machinist/active_record'
require 'faker'

User.blueprint do
  username {"test"}
  email {"#{object.username}@localhost.com"}
end

Location.blueprint do
  latitude { 1.0 }
  longitude { 1.0 }
  user_id { User.make.id }
end

Route.blueprint do
  name {"test route"}
  user_id { User.make.id }
  locations(3)
end
