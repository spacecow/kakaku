class User < ActiveRecord::Base
  has_many :resets
  
  attr_accessible :username, :pc_email, :mob_email, :password, :password_confirmation, :question, :alt_question, :answer, :answer_confirmation, :first_name, :last_name, :first_name_kana, :last_name_kana, :male, :home_tel, :mob_tel, :generate_address, :prefecture, :zip3, :zip4, :ward_area, :birth, :building_room
  
  attr_accessor :password
  before_save :prepare_password
  before_save :set_roles
  before_save :set_question
  
  validates_presence_of :username, :first_name, :last_name, :first_name_kana, :last_name_kana, :prefecture, :ward_area
  validate :both_question_and_alternative_question_cannot_be_blank
  validate :both_question_and_alternative_question_cannot_be_filled_in
  validate :both_emails_cannot_be_blank
  validate :both_tels_cannot_be_blank
	validate :kana_format_of_first_name_kana
	validate :kana_format_of_last_name_kana	
  validates_uniqueness_of :username, :pc_email, :mob_email, :home_tel, :mob_tel, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validate :mail_must_look_like_an_email_adresses
  validate :tel_must_look_like_a_telephone_number
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of :answer, :on => :create
  validates_confirmation_of :answer  
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_inclusion_of :male, :in => [false, true], :message => I18n.t('activerecord.errors.messages.blank')
	validate :must_be_a_zip_code

	ROLES = %w[registrant]
	QUESTIONS = %w(q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 qalt)
	PREFECTURES = %w[北海道 青森県 秋田県 岩手県 新潟県 山形県 宮城県 石川県 富山県 栃木県 福島県 福井県 長野県 群馬県 埼玉県 茨城県 島根県 鳥取県 兵庫県 京都府 滋賀県 岐阜県 山梨県 東京都 千葉県 山口県 広島県 岡山県 大阪府 奈良県 愛知県 静岡県 神奈川県 佐賀県 福岡県 和歌山県 三重県 長崎県 熊本県 大分県 愛媛県 香川県 鹿児島県 宮崎県 高知県 徳島県 沖縄県]
		
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_pc_email(login) || find_by_mob_email(login)
    return user if user && user.matching_password?(pass)
  end
  
  def generate_address=( s )
  	#p "-------------------------------"
  	#p s
  	#self.prefecture = Address.find_by_zip( zip ).prefecture unless Address.find_by_zip( zip ).nil?
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  def role?( role )
  	roles.include? role.to_s
  end
  
	def zip
		(zip3 || "") + (zip4 || "")
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

  def must_be_a_zip_code
  	numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9"}
  	numbers.each{|k,v| zip3.gsub!(/#{k}/, "#{v}")} if !zip3.nil? && zip3.match(/[０-９]/)
  	numbers.each{|k,v| zip4.gsub!(/#{k}/, "#{v}")} if !zip4.nil? && zip4.match(/[０-９]/)
  	errors.add(:zip3, I18n.t('activerecord.errors.messages.blank')) if zip3.blank?
  	errors.add(:zip4, I18n.t('activerecord.errors.messages.blank')) if zip4.blank?
  	errors.add(:zip3, I18n.t('error.message.must_be_digits',:no=>3)) unless zip3.match(/^\d\d\d$/) unless errors.on(:zip3)
  	errors.add(:zip4, I18n.t('error.message.must_be_digits',:no=>4)) unless zip4.match(/^\d\d\d\d$/) unless errors.on(:zip4)
  	
  	address = Address.find_by_zip( zip )
  	unless address.nil?
  		self.prefecture = address.prefecture
  		self.ward_area = address.ward + address.area
		end
  end

	def display( text )
		"<span id='category'>"+I18n.t( text )+"</span>: "+send( text ).to_s
	end

private
	
	def both_question_and_alternative_question_cannot_be_filled_in
		errors.add(:question, I18n.t('error.message.both_filled_in')) unless question.blank? || alt_question.blank? || question == "qalt"
		errors.add(:alt_question, I18n.t('error.message.both_filled_in')) unless alt_question.blank? || question.blank? || question == "qalt"
	end
	
	def both_emails_cannot_be_blank
		errors.add(:pc_email, I18n.t('error.message.both_blank'),:object=>I18n.t(:mail)) if pc_email.blank? && mob_email.blank?
		errors.add(:mob_email, I18n.t('error.message.both_blank'),:object=>I18n.t(:mail)) if pc_email.blank? && mob_email.blank?
	end
	
	def both_tels_cannot_be_blank
		errors.add(:home_tel, I18n.t('error.message.both_blank'),:object=>I18n.t(:phonenumber)) if home_tel.blank? && mob_tel.blank?
		errors.add(:mob_tel, I18n.t('error.message.both_blank'),:object=>I18n.t(:phonenumber)) if home_tel.blank? && mob_tel.blank?		
	end

	def both_question_and_alternative_question_cannot_be_blank
		errors.add(:question, I18n.t('activerecord.errors.messages.blank')) if question.blank? && alt_question.blank?
		errors.add(:alt_question, I18n.t('activerecord.errors.messages.blank')) if alt_question.blank? && ( question.blank? || question == "qalt" )
	end

	def	kana_format_of_first_name_kana
		errors.add(:first_name_kana, I18n.t('error.message.must_be_kana')) unless first_name_kana.match(/^[ーァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワン]*$/) unless errors.on(:first_name_kana)
	end

	def	kana_format_of_last_name_kana
		errors.add(:last_name_kana, I18n.t('error.message.must_be_kana')) unless last_name_kana.match(/^[ーァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワン]*$/) unless errors.on(:last_name_kana)
	end
  
  def mail_must_look_like_an_email_adresses
  	errors.add(:pc_email, I18n.t('activerecord.errors.messages.invalid')) unless pc_email.match(/^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i) unless errors.on(:pc_email) || (!mob_email.blank? && pc_email.blank?)
  	errors.add(:mob_email, I18n.t('activerecord.errors.messages.invalid')) unless mob_email.match(/^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i) unless errors.on(:mob_email) || (!pc_email.blank? && mob_email.blank?)
  end
  
  def tel_must_look_like_a_telephone_number
  	#numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9", "ー"=>"", "-"=>""}
  	#numbers.each{|k,v| home_tel.gsub!(/#{k}/, "#{v}")} if !home_tel.nil? && home_tel.match(/[-ー０-９]/)
  	#numbers.each{|k,v| mob_tel.gsub!(/#{k}/, "#{v}")} if !mob_tel.nil? && mob_tel.match(/[-ー０-９]/)

		home_tel.gsub!(/\D/,'') unless home_tel.nil?
		mob_tel.gsub!(/\D/,'') unless home_tel.nil?
  	errors.add(:home_tel, I18n.t('activerecord.errors.messages.invalid')) unless home_tel.match(/^[0-9]+$/) unless errors.on(:home_tel) || (!mob_tel.blank? && home_tel.blank?)
  	errors.add(:mob_tel, I18n.t('activerecord.errors.messages.invalid')) unless mob_tel.match(/^[0-9]+$/) unless errors.on(:mob_tel) || (!home_tel.blank? && mob_tel.blank?)  	
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
