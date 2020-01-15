module ApplicationHelper
  def base_url
    port = request.port != 80 ? ":#{request.port}" : ''
    @base_url ||= "#{request.scheme}://#{request.host}#{port}"
  end
end
