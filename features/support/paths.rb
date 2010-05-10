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
	        
		when /^the show page (?:for|of) user with username: "(.+)"$/
			"/users/#{$1}"

		when /^the (?:error )?(?:(admin) )?show page (?:for|of) (.+)$/
			( $1 ? "/#{$1}" : "" ) + polymorphic_path( model($2) )
		
		when /^the (security) page (?:for|of) (.+)$/
			polymorphic_path( model($2) ) + "/#{$1}"
			      
		when /^the (?:(admin) )?edit page (?:for|of) (.+)$/
			( $1 ? "/#{$1}" : "" ) + edit_polymorphic_path( model($2) )

		when /^the (?:error )?(.+?) page$/
      send "#{$1.downcase.gsub(' ','_')}_path"

		when /^the admin (comfirm delete) page (?:for|of) (.+)$/
			"/admin"+polymorphic_path( model($2) )+"/confirm_delete"

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
