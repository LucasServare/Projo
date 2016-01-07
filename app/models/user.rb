class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :projects
  has_many :to_do_items

  def name
    first_name + ' ' + last_name
  end

end
