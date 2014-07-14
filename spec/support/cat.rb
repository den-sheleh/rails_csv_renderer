class Cat < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :person
end
