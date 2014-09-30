#Schema Info
# table name: users

# id          :integer      not null, primary key
# name        :string (255)
# email       :string (255)
# created_a   :datetime
# updated_at  :datetime
  

class User < ActiveRecord::Base
  #This line below did not work
 # attr_accessible :name, :email
  
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
  
end
