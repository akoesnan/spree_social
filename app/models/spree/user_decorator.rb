Spree::User.class_eval do
  has_many :user_authentications

  devise :omniauthable

  def apply_omniauth(omniauth)
    if omniauth['provider'] == "facebook"
      info = omniauth['info']
      self.email = info['email'] if email.blank?
      self.first_name = info['first_name'] if first_name.blank?
      self.last_name = info['last_name'] if last_name.blank?

      #self.nickname = info['nickname'] if first_name.blank?
      self.image_url = info['image']
    end

    access_token = omniauth['credentials']['token']
    access_token_expires_at = Time.at(omniauth['credentials']['expires_at']).to_time
    user_authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :access_token => access_token, :access_token_expires_at => access_token_expires_at)
  end

  def update_omniauth(omniauth, auth)
    if omniauth['provider'] == "facebook"
      info = omniauth['info']
      self.email = info['email'] if email.blank?
      self.first_name = info['first_name'] if first_name.blank?
      self.last_name = info['last_name'] if last_name.blank?

      #self.nickname = info['nickname'] if first_name.blank?
      self.image_url = info['image']
    end

    auth.access_token = omniauth['credentials']['token'];
    auth.access_token_expires_at = Time.at(omniauth['credentials']['expires_at']).to_time;
  end

  def password_required?
    (user_authentications.empty? || !password.blank?) && super
  end
end
