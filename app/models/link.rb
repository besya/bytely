class Link < ActiveRecord::Base
  has_many :unique_redirects
  has_many :redirects

  validates :url, :token, presence: true, uniqueness: true
  validates_format_of :url,
                      with: %r{\A(https?://)([\da-z\.-]+)\.([a-z\.]{2,6})([/\w\.-]*)*/?\Z}i
end
