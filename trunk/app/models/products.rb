class Products < ActiveRecord::Base

 attr_accessible :id, :category_id, :description, :imageurl, :name, :price, :currency, :user_id

 validates :name, presence: true
 validates :price, presence: true
 validates :category_id, presence: true

searchable do
    text :name, :description, :price
end



def self.uploadfile(upload)
  name =  upload['datafile'].original_filename
  directory = "public/upload/images/"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end

  # def self.truncate(text, length = 30, truncate_string = "...")
  #   if text
  #     l = length - truncate_string.chars.length
  #     chars = text.chars
  #     (chars.length > length ? chars[0...l] + truncate_string :text).to_s
  #   end
  # end
end
