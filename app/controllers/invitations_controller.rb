class InvitationsController < ApplicationController
    before_filter :signed_in_user, only: [:new, :create]
    before_filter :validate_invited_user, only: [:create]

    def new
        @invitation = Invitation.new
    end
    
    def create
        @invitation = Invitation.new( params[:invitation] )
        
        #-- Give some identity to the invitation
        @invitation.user = current_user
        @invitation.organization = current_user.organization

        if @invitation.save
            #-- Give some identity to the invitation
            begin
                InvitationMailer.invitation_new_user(@invitation).deliver
                flash[:success] = "Invitation Sent!"
            rescue
                @invitation.destroy
                flash[:error] = "Error While sending the email, please try later!"
                #-- TODO : To log detailed error desc...
            end
            redirect_to users_path
            return
        end
        
        render 'new'
    end
      
    def accept
        @invitation = Invitation.find_by_token_character( params[:token_id] )
      
        if @invitation.nil?
          redirect_to root_path, notice: "Invalid Token in request."
          return
        end
        #-- Sign Out if signed in as any user
        sign_out if signed_in?

        @user = User.find_by_email( @invitation.recipient_email )
        unless user.nil?
            redirect_to signin_url, notice: "Already a member!"
            return
        end
        
        @user = User.new(:email => @invitation.recipient_email )
        @user.organization = @invitation.organization
        
        render 'users/new'
    end
      
      
    private

        def signed_in_user
            unless signed_in?
                store_location
                redirect_to signin_url, notice: "Please sign in."
            end
        end
        
        def validate_invited_user
            @user = User.find_by_email( params[:invitation][:recipient_email] )
            return if @user.nil?

            flash[:error] = "This user is already associated with #{@user.organization.name} organization"
            redirect_to new_invitation_url
        end
end
