class Comments < ActiveRecord::Base
   attr_accessible :user_id, :product_id, :content

   validates_presence_of :user_id, :message => "please login for this action!" 
   validates :product_id, presence: true
   validates :content, length: { maximum: 500, minimum: 3}
end
