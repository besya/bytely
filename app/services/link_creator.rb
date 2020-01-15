class LinkCreator < Service
  TOKEN_LENGTH = 8

  def initialize(url, token_generator)
    @url = url
    @token_generator = token_generator
  end

  def call
    link = find_link
    return link if link

    invalid_link = validate_link
    return invalid_link if invalid_link

    Link.create url: @url, token: unique_token
  end

  private

  def validate_link
    link = Link.new(url: @url).tap(&:valid?)
    link.errors[:url].present? ? link : nil
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
