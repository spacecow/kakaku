class Address < ActiveRecord::Base
	def self.generate_database
		filename = 'ken_all.csv'
		
		Address.delete_all
		
		File.open filename, 'r' do |f|
			f.readlines.each_with_index do |line,i|
				p i if i%1000==0
				array = line.split(',')
				Address.create(
					:zip => array[2].gsub(/"/, ''),
					:prefecture => array[6].gsub(/"/, ''),
					:ward => array[7].gsub(/"/, ''),
					:area => array[8].gsub(/"/, '')
				)
			end
		end
	end
end
