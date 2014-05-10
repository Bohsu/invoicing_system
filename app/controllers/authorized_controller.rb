# -*- encoding : utf-8 -*-

class AuthorizedController < ApplicationController
  # devise方法验证用户登陆
  before_filter :authenticate_user!
  # before_filter :check_permission

  # cancan方法效验用户权限 确保每一个action执行cancan
  # 跳过该验证skip_authorization_check
  # check_authorization
  # load_resource 自动生成@object = Obeject.find(params[:id])
  # authorize_resource 根據 CanCan::Ability 裡的權限表
  # 跳过该验证skip_load_and_authorize_resource,一般不是scaffold风格的controller都跳过。
  # load_and_authorize_resource

 
end

