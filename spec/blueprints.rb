require 'machinist/active_record'
require 'faker'

User.blueprint do
  username {"test"}
  email {"#{object.username}@localhost.com"}
end

Route.blueprint do
  name {"test route"}
  user(1)
  locations(3)
end
