class Link < ActiveRecord::Base
  has_many :unique_redirects
  has_many :redirects

  validates :url, :token, presence: true, uniqueness: true
  validates_format_of :url,
                      with: %r{\A(https?://)([\w\-\.]+\w)(\:\d+)?(((/[\w\-]*)+)(\.\w*)?)?(\?[^\n]*)?\z}
end
