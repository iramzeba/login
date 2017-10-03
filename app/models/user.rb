class User < ApplicationRecord
   #Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password , presence: true
	validates :confirm, presence: true
	validates :mobile, presence: true, numericality: true
  
  
    before_save :encrypt_password
    before_save :check_name
    before_validation :verify_password
   devise :omniauthable

   def admin?
     self.roles.pluck(:name).include?("admin")
  end
def check_name
  if name.blank?
    self.name="unknow"
  end
end

def self.omniauth(auth)
    #where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
     where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      byebug
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.profile_image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save(validate: false)
    end
  end

    def encrypt_password
      unless password.nil?
       self.password = Digest::MD5.hexdigest(password)
       self.confirm_password = Digest::MD5.hexdigest(confirm_password)
      end 
    end

    def verify_password
      unless password.nil? 
        if password != confirm_password
             errors.add(:base, "password & confirm_password are not equal!" )
        end
      end
    end
  def self.authenticate(email, password)
    if @user = User.where(email: email, password: Digest::MD5.hexdigest(password)).last
           @user
       else
        nil
       end
  end
end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable

#def send_devise_notification(notification, *args)
 # devise_mailer.send(notification, self, *args).deliver_later
#end
