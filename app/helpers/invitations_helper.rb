module InvitationsHelper
  def create_join_link(invitation)
    join_url = "http://localhost:3000/invitations/accept/#{invitation.token_character}"
    link_to( "Join", join_url)
  end

end
