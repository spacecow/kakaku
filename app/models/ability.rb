class Ability  
  include CanCan::Ability  
  
  def initialize(user)  
		can :create, User

		user ||= User.new
		can :show, User do |u|
			u == user
		end
		if user.role? :admin
			can :manage, :all
		end
  end  
end