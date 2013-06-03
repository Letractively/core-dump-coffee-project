class Categories < ActiveRecord::Base
  attr_accessible :name, :description

 validates :name, presence: true
 validates :description, presence: true

end
