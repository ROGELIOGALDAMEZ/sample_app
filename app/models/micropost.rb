#Schema Info
# table name: Microposts

# id          :integer      not null, primary key
# content     :string (255)
# user_id     :integer
# created_at   :datetime
# updated_at  :datetime


class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user #Assosciation to the Users table
  
  validates :content, :presence => true, :length => {:maximum => 140}
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC' #pulling posts in descending order when they were created  
  
end
