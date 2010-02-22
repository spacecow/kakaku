class Reset < ActiveRecord::Base
	belongs_to :user
	
	attr_accessor :login
	
	validates_presence_of :login
	validate :login_must_exist
	
	before_create :generate_token
		
private
	
	def login_must_exist
		errors.add :login, I18n.t('error.message.does_not_exist') if User.find_by_username( login ).nil? && User.find_by_email( login ).nil?
	end		
	
	def generate_token
		self.token = Digest::SHA1.hexdigest([ Time.now, rand ].join )	
	end		
end
