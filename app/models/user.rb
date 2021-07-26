class User < ActiveRecord::Base
  has_secure_password


  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }

  def self.authenticate_with_credentials(email,password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      return user
    end
    return nil
  end
  
end
