class Address < ActiveRecord::Base
	def self.generate_database
		filename = 'ken.csv'
		
		Address.delete_all
		
		File.open filename, 'r' do |f|
			f.readlines.each do |line|
				array = line.split(',')
				Address.create(
					:zip => array[0].gsub(/"/, ''),
					:prefecture => array[1].gsub(/"/, ''),
					:ward => array[2].gsub(/"/, ''),
					:area => array[3].gsub(/"/, '')
				)
				Address.all
			end
		end
	end
end
