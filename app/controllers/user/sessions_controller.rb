# -*- encoding : utf-8 -*-

class User::SessionsController < Devise::SessionsController

  layout "login"

  def new
  end

  def create
    super
  end

  private
  def after_sign_in_path_for(resource)
    mytp_home_index_path
  end

end
