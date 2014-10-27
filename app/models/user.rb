#Schema Info
# table name: users

# id          :integer      not null, primary key
# name        :string (255)
# email       :string (255)
# created_a   :datetime
# updated_at  :datetime
# encrypted_password :string(255)
  

class User < ActiveRecord::Base
  
  attr_accessor   :password
  attr_accessible :name, :email, :password, :password_confirmation
 
  
  
  #checking to ensure a name has been specified
  validates :name, :presence => true,
  #ensure name is no more than 50 chars
                   :length => {:maximum => 50}
  
  #checking to ensure an email has been specified
  validates :email, :presence => true
  #checking to ensure correct email format has been entered
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  #checking to ensure the email is unique eg; doesnt already exist
  validates :email, :uniqueness => {:case_sensitive => false}
  
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40}
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password) #comparing encrypted password by encrypting the submitted vs stored
  end
  
  class <<self
    
    def authenticate(email, submitted_password)
      user = find_by_email(email)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
    
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
    
  end
  
  private
  
    def encrypt_password
        self.salt = make_salt if new_record?
        self.encrypted_password = encrypt(self.password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end
