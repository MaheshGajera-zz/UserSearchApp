class InvitationMailer < ActionMailer::Base
    default from: "no-reply@taskmanager.com"
    
    def invitation_new_user( invitation )
        @invitation = invitation
        mail( :to => invitation.recipient_email, :subject => "Task Manager Invitation" )
    end
end
