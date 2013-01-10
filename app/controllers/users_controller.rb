class UsersController < ApplicationController
    before_filter :signed_in_user, only: [:index, :edit, :update]
    before_filter :correct_user,   only: [:edit, :update]
    
    def index
        #-- List of all Users which belongs to signed in user's Organization
        @users = current_user.organization.users
    end
    
    def new
        @user = User.new
    end
    
    def create
        org_id = params[:user][:organization_id]
        params[:user].delete(:organization_id)
        @user = User.new( params[:user] )
        @user.organization = Organization.find(org_id)
        
        if @user.save
            flash[:success] = "Account has been created!"
            sign_in @user
            
            #-- Lets Remove this users invitations
            begin
                Invitation.find_by_recipient_email( @user.email ).destroy
            rescue
                #-- TODO: Log Errors
            end
            
            redirect_to tasks_path
        else
            render 'new'
        end
    end
    
    def edit
        @user = User.find( params[:id] )
    end
  
    def update
        @user = User.find( params[:id] )
        if @user.update_attributes( params[:user] )
            flash[:success] = "Profile updated"
            sign_in @user
            redirect_to tasks_path
        else
            render 'edit'
        end
    end
  
  
    private

        def signed_in_user
            unless signed_in?
              store_location
              redirect_to signin_url, notice: "Please sign in."
            end
        end
    
        def correct_user
            @user = User.find(params[:id])
            redirect_to(tasks_path) unless current_user?(@user)
        end
end