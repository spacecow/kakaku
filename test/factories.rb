Factory.define :user do |f|
	f.sequence(:username){|n| "username#{n}" }
	f.password "secret"
	f.sequence(:mob_tel){|n| "#{n}" }
	f.sequence(:mob_email){|n| "mob_mail#{n}@another.fake.domain.com" }
	f.question "Where did you spend your childhood summers?"
	f.answer "I am not going to tell you that!"
	f.male true
	f.first_name_kana "ファースト"
	f.last_name_kana "ラスト"
	f.first_name "First"
	f.last_name "Last"
	f.zip3 "123"
	f.zip4 "4567"
end

Factory.define :reset do |f|
	f.user {|u| u.association( :user, :username => "username1" ) }
	f.username "username1"
end