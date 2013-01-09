class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.string :token_character
      t.integer :organization_id

      t.timestamps
    end
  end
end
