class Country < ActiveRecord::Base
  has_many :redirects

  validates :name, uniqueness: true
end
