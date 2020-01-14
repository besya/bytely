class Country < ActiveRecord::Base
  has_many :unique_redirects
  has_many :redirects

  validates :name, uniqueness: true
end
