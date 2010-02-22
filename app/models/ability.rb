class Ability  
  include CanCan::Ability  
  
  def initialize(user)  
		if user == "admin"
			can :manage, :all
		elsif
			user ||= User.new
			if user.role? :registrant
				can :show, User do |u|
					u == user
				end
			else
				can [:create, :change_password, :update_password], User
				can [:create, :question], Reset
			end
		end
  end  
end