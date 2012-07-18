class Spree::UserAuthentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :access_token, :access_token_expires_at
  belongs_to :user
end
