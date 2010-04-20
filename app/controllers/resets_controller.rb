class ResetsController < ApplicationController
  load_and_authorize_resource
  
  def new
  end
  
  def create
  	if @reset.save
  		user = User.find_by_username( @reset.login ) || User.find_by_pc_email( @reset.login ) || User.find_by_mob_email( @reset.login )
      @reset.update_attribute( :user_id, user.id )
  		#Mailer.send_later( :deliver_reset_password, @reset, reset_password_url( @reset.token ))
  		Mailer.send( :deliver_reset_password, @reset, reset_password_url( @reset.token ))
  		flash[:notice] = t('notice.mail_sent')
  		redirect_to root_path
		else
			render :action => :new
		end
  end
  
  def question
  	@login = params[:login]
  	user = User.find_by_username( @login ) || User.find_by_pc_email( @login )
  	if user.nil?
			flash.now[:error] = t('error.login_does_not_exist') unless params[:login].nil?
		else
  		@question = user.question
  		unless params[:answer].nil?
  			if user.answer_hash == User.encrypted_answer( params[:answer], user.answer_salt )
					flash[:notice] = t('notice.correct_answer')
					reset = Reset.create!( :user_id=>user.id, :login=>params[:login] )
					redirect_to reset_password_path( reset.token )
				else
					flash.now[:error] = t('error.incorrect_answer')
				end
			end
  	end
  end
end
