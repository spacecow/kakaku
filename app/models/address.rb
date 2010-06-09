class Address < ActiveRecord::Base
	has_many :users
	accepts_nested_attributes_for :users
	  
	def zip
		p "hej"
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
end
