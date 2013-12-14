Fabricator(:user) do
  email { Faker::Internet.email }
  password "password"
  password_confirmation "password"
  full_name { Faker::Name.name }
end

Fabricator(:password_recovery) do
  user
end

Fabricator(:keychain) do
  name { Faker::Lorem.words(2).join(" ")}
  description { Faker::Lorem.paragraph }
  username { rand(1000000) }
  password { rand(10000000) }
end
