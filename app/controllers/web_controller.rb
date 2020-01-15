class WebController < ApplicationController
  configure do
    use Rack::Static, index: 'public/index.html'
  end

  set root: File.dirname(__FILE__) + '/../..'
  set public_folder: root + '/public'

  get '/:token' do
    link = find_link

    redirect to('/') unless link

    register_redirect link
    redirect to(link.url)
  end

  private

  def find_link
    Link.find_by token: params[:token]
  end

  def register_redirect(link)
    Resque.enqueue RedirectRegisterJob, request.ip, link.id
  end
end
