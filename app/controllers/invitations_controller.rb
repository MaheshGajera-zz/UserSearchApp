class InvitationsController < ApplicationController
    before_filter :signed_in_user
    before_filter :validate_invited_user, only: [:create]

    def new
        @invitation = Invitation.new
    end
    
    def create
        @invitation = Invitation.new( params[:invitation] )
        @invitation.user = current_user
        @invitation.organization = current_user.organization
            
        if @invitation.save
            flash[:success] = "Invitation Sent!"

            InvitationMailer.invitation_new_user(@invitation).deliver

            redirect_to users_path
        else
          render 'new'
        end
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

            flash[:success] = "This user is already associated with #{@user.organization.name} organization"
            redirect_to new_invitation_url
        end
end
