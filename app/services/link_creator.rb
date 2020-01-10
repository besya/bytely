class LinkCreator < Service
  TOKEN_LENGTH = 8

  def initialize(token_generator, url)
    @token_generator = token_generator
    @url = url
  end

  def call
    link = find_link
    return link if link

    link = prepare_link
    return link unless link.errors[:url].empty?

    Link.create url: @url, token: unique_token
  end

  private

  def prepare_link
    Link.new(url: @url).tap(&:valid?)
  end

  def unique_token
    while Link.exists?(token: (token = new_token)); end
    token
  end

  def new_token
    @token_generator.call(TOKEN_LENGTH)
  end

  def find_link
    Link.find_by url: @url
  end
end
