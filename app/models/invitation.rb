class Invitation < ActiveRecord::Base
  attr_accessible :recipient_email, :token_character
  
  belongs_to :organization
  belongs_to :user, :foreign_key => "sender_id"
  
  before_save { |invitation| invitation.recipient_email = recipient_email.downcase }
  before_save :create_token_character
  
  validates :sender_id, presence: true
  validates :organization_id, presence: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :recipient_email, presence: true, format: { with: VALID_EMAIL_REGEX }

  private
  
      def create_token_character
        self.token_character = SecureRandom.urlsafe_base64
      end
end
