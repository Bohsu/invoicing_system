class Mytp::HomeController < Mytp::BaseController

  layout  "admin"

  def welcome
    render layout: 'admin_content'
  end
end
