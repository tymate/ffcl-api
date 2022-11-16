class ChangeInvitationCodeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :clubs, :invitation_code, :string, limit: 6
  end
end
