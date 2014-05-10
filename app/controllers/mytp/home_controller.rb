class Mytp::HomeController < ApplicationController

  layout  "admin"

  def welcome
    render layout: 'admin_content'
  end
end
