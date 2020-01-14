class Redirect < ActiveRecord::Base
  belongs_to :link, counter_cache: true
  belongs_to :country, counter_cache: true
  belongs_to :unique_redirect, counter_cache: true
end
