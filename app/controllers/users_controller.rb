class UsersController < ApplicationController
  before_filter :find_page_by_id_or_username, :only => :show
  load_and_authorize_resource
  
  def show
  end
  
  def new
  	@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
  	@user.address ||= Address.new
  	#p @user.address
  end
    
  def create
  	#p params[:user][:address_attributes]
  	#@user.address ||= Address.new
		@user = User.new( params[:user] )
		@user.address ||= Address.new
		@user.address.attributes = params[:user][:address_attributes]

  	@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
    if !params[:user][:generate_address].nil?
    	#@user = User.new( :zip3 => params[:user][:zip3] )
    	#@user.save!
    	@user.address.must_be_a_zip_code
    		#@user.prefecture = ""
    		#@user.ward_area = ""
    		#@user.building_room = ""
  		#end
    	render :action => 'new'
    elsif @user.save
    	p @user.address
      session[:user_id] = @user.id
      flash[:notice] = t('message.signup_thanks')+" "+t('message.logged_in')
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

	def edit
		@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
	end

	def update
		if !params[:user][:generate_address].nil?
    	#@user = User.new( :zip3 => params[:user][:zip3] )
    	#@user.save!
    	unless @user.must_be_a_zip_code(params[:user][:zip3],params[:user][:zip4])
    		@user.prefecture = ""
    		@user.ward_area = ""
    		@user.building_room = ""    		
  		end
    	@user.zip3 = params[:user][:zip3]
    	@user.zip4 = params[:user][:zip4]
    	render :action => 'edit'
    elsif @user.update_attributes( params[:user] )
			flash[:notice] = t('notice.updated', :object=>t(:user))
			redirect_to @user
		else
			@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
			render :action => :edit
		end		
	end

	def change_password
		@token = params[:token]
		reset = Reset.find_by_token( @token )
		if reset.nil?
			flash[:error] = t('error.no_token')
			redirect_to root_path and return 
		end
		if reset.used
			flash[:error] = t('error.used_token')
			redirect_to root_path and return 
		end
		@user = reset.user
	end
	
	def update_password
		@token = params[:token]
		reset = Reset.find_by_token(params[:token])
		@user = reset.user
		
		if @user.update_attributes(params[:user])
			if params[:user][:password].blank?
				flash.now[:error] = t('error.blank_password')
				render :action => 'change_password' and return
			end
			session[:user_id] = @user.id
    	flash[:notice] = t('notice.change_success')+" "+t('message.logged_in')
    	reset.update_attribute( :used, true )
    	#@reset_password.destroy
    	redirect_to root_path
    else
      render :action => 'change_password'
    end
	end

	def security
		@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
	end

	def security_update
		user = User.authenticate(@user.username, params[:old_password])
		if user || admin?
			if @user.update_attributes( params[:user] )
				if admin?
					flash[:notice] = t('notice.updated_what_for', :object=>t(:security_settings), :person=>@user.username)
				else
					flash[:notice] = t('notice.updated', :object=>t(:security_settings))
				end
				redirect_to @user
			else
				@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
				render :action => :security
			end
    else
    	@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
      flash.now[:error] = t('error.provide_password')
      render :action => 'security'
    end			
	end

private

  def find_page_by_id_or_username
    @user = params[:id].to_i == 0 ? User.find_by_username( params[:id] ) : User.find( params[:id])
  end  
end
