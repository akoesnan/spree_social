class AddAccessTokenAndImage < ActiveRecord::Migration
  def change
    add_column :spree_user_authentications, :access_token, :string
    add_column :spree_user_authentications, :access_token_expires_at, :datetime
    add_column :spree_users, :image_url, :string
  end
end
