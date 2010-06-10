class Address < ActiveRecord::Base
	has_many :users
#	validates_presence_of :prefecture
	validates_uniqueness_of :zip
	validate :must_be_a_zip_code
	attr_writer :zip3, :zip4

	def zip3
		@zip3 || (zip.nil? ? "" : self.zip[0..2])
	end
	
	def zip4
		@zip4 || (zip.nil? ? "" : self.zip[3..6])
	end
			
	def self.generate_default_csv
		generate_csv( 'data/ken.utf' )
	end
	
	def self.generate_csv( file )
		Address.delete_all
		File.open file.gsub(/\.utf/,'.csv'), 'w' do |outfile|
			File.open file, 'r' do |infile|
				infile.readlines.each_with_index do |line,i|
					p i if i%1000==0
					array = line.split(',')
					outfile.write [(i+1).to_s, array[2], array[6], array[7], array[8]].
						map{|e| e.gsub(/"/,'')}.join(',')+"\n"
				end
			end
		end
	end

  def must_be_a_zip_code
  	numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9"}
  	numbers.each{|k,v| zip3.gsub!(/#{k}/, "#{v}")} if !zip3.nil? && zip3.match(/[０-９]/)
  	numbers.each{|k,v| zip4.gsub!(/#{k}/, "#{v}")} if !zip4.nil? && zip4.match(/[０-９]/)
  	errors.add(:zip, I18n.t('activerecord.errors.messages.blank')) if zip3.blank? && zip4.blank?
  	errors.add(:zip, I18n.t('error.message.must_be_digits',:no1=>3,:no2=>4)) unless zip3.match(/^\d\d\d$/) && zip4.match(/^\d\d\d\d$/) unless errors.on(:zip)
  	
#  	address = Address.find_by_zip( zip3+zip4 )
#  	p zip3 + zip4
#  	if address.nil?
#  		errors.add(:zip, I18n.t('error.message.zip_code_does_not_exist')) unless errors.on(:zip)
#  	else
#  		#self.prefecture = address.prefecture
#  		#self.ward_area = address.ward + address.area
#		end
#		!address.nil?
  end
end
