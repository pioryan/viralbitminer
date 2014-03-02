class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications, :dependent => :delete_all


  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    if auth['extra']['raw_info']['email'].present?
      self.email = auth['extra']['raw_info']['email']
    elsif auth['info']['nickname'].present?
      self.nickname = auth['info']['nickname']
      self.email = "#{self.nickname}@viralbitminer.com"
    end

    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end
end
