class User < ActiveRecord::Base
  has_many :resets
  
  attr_accessible :username, :email, :password, :password_confirmation, :question, :alt_question, :answer, :answer_confirmation
  
  attr_accessor :password
  before_save :prepare_password
  before_save :set_roles
  before_save :set_question
  
  validate :both_question_and_alternative_question_cannot_be_blank
  validate :both_question_and_alternative_question_cannot_be_filled_in
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of :answer, :on => :create
  validates_confirmation_of :answer  
  validates_length_of :password, :minimum => 4, :allow_blank => true

	ROLES = %w[registrant]
	QUESTIONS = %w(q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 qalt)
  
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  def role?( role )
  	roles.include? role.to_s
  end
  
  def alt_question
  	@alt_question
  end
  
  def alt_question=(question)
  	@alt_question = question
  end

  def answer
    @answer
  end

  def answer=( awr )
    @answer = awr
    return if awr.blank?
    create_new_salt
    self.answer_hash = User.encrypted_answer( self.answer, self.answer_salt )
  end

private
	
	def both_question_and_alternative_question_cannot_be_filled_in
		errors.add(:question, I18n.t('error.message.both_filled_in')) unless question.blank? || alt_question.blank? || question == "qalt"
		errors.add(:alt_question, I18n.t('error.message.both_filled_in')) unless alt_question.blank? || question.blank? || question == "qalt"
	end
	
	def both_question_and_alternative_question_cannot_be_blank
		errors.add(:question, I18n.t('activerecord.errors.messages.blank')) if question.blank? && alt_question.blank?
		errors.add(:alt_question, I18n.t('activerecord.errors.messages.blank')) if alt_question.blank? && ( question.blank? || question == "qalt" )
	end
  
	def set_question
		self.question = @alt_question if self.question.blank? || self.question == "qalt"
	end
	
  def set_roles
		self.roles = ['registrant']
	end
	
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def create_new_salt
    self.answer_salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_answer( answer, salt )
    string_to_hash = answer + "cobra" + salt
    Digest::SHA1.hexdigest( string_to_hash )
  end  
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
  
	def roles=(roles)  
	 self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum  
	end  
	 
	def roles  
	 ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }  
	end
end
