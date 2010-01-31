Factory.define :user do |f|
	f.password "secret"
	f.sequence(:email){|n| "mail#{n}@another.fake.domain.com" }
end