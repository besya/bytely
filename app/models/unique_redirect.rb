class UniqueRedirect < ActiveRecord::Base
  has_many :redirects
  belongs_to :country, counter_cache: true
  belongs_to :link, counter_cache: true
end
