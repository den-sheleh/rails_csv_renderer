class Person < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  has_many :cats

  def full_name
    "#{ first_name} #{ last_name }"
  end

  class << self
    def csv_header
      [human_attribute_name(:id), human_attribute_name(:full_name)]
    end
  end

  def csv_row
    [id, full_name]
  end
end
