Factory.define :address do |f|
end

Factory.define :reset do |f|
	f.user {|u| u.association( :user, :username => "username1" ) }
	f.username "username1"
end

Factory.define :user do |f|
	f.sequence(:username){|n| "username#{n}" }
	f.password "secret"
	f.sequence(:mob_tel){|n| "#{n}" }
	f.sequence(:mob_email){|n| "mob_mail#{n}@another.fake.domain.com" }
	f.sequence(:pc_email){|n| "pc_mail#{n}@another.fake.domain.com" }
	f.question "q1"
	f.answer "I am not going to tell you that!"
	f.male true
	f.first_name_kana "ファースト"
	f.last_name_kana "ラスト"
	f.first_name "First"
	f.last_name "Last"
	f.address {|u| u.association( :address, :zip => "1234567" ) }
end