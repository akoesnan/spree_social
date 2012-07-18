class Spree::AuthenticationMethod < ActiveRecord::Base
  attr_accessible :provider, :api_key, :api_secret, :environment, :active, :app_namespace

  def self.active_authentication_methods?
    found = false
    where(:environment => ::Rails.env).each do |method|
      if method.active
        found = true
      end
    end
    return found
  end

  def self.facebook_authentication_method
    authMethods = Spree::AuthenticationMethod.where(:active => true, :environment => ::Rails.env, :provider => :facebook);
    if (authMethods.any?)
      authMethods.first
    else
      nil
    end
  end

  scope :available_for, lambda { |user|
    sc = where(:environment => ::Rails.env)
    sc = sc.where(["provider NOT IN (?)", user.user_authentications.map(&:provider)]) if user and !user.user_authentications.empty?
    sc
  }
end
