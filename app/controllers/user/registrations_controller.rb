# -*- encoding : utf-8 -*-

class User::RegistrationsController < Devise::RegistrationsController

  skip_before_filter :require_no_authentication, :only => [:new]  

  layout 'login'

  def new
  end

  def create
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "注册成功"
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        flash[:error] = "error"
        render :new
      end
  end

  private
  def after_sign_in_path_for(resource)
    return new_user_session_path
    super
  end

end
