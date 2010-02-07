Factory.define :user do |f|
	f.sequence(:username){|n| "username#{n}" }
	f.password "secret"
	f.sequence(:email){|n| "mail#{n}@another.fake.domain.com" }
end