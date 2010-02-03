module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
		when /the root page/
			'/'
    
		when /path "(.+)"/
			$1
	
		when /^the (?:error )?(.+?) page$/
      send "#{$1.downcase.gsub(' ','_')}_path"
        
		when /^the (?:error )?show page (?:for|of) (.+)$/
			polymorphic_path( model($1) )
			      
		when /^the (?:(.+)\s)?edit page (?:for|of) (.+)$/
			( $1 ? "/#{$1}" : "" ) + edit_polymorphic_path( model($2) )

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
