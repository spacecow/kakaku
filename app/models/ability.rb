class Ability  
  include CanCan::Ability  
  
  def initialize(user)  
		if user == "admin"
			can :manage, :all
		elsif
			can :create, User

			user ||= User.new
			can :show, User do |u|
				u == user
			end
		end
  end  
end