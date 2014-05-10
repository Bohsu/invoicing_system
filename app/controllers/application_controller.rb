# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base

  respond_to :html, :json, :js

  protect_from_forgery

  include Exts
  include XmlParser
  include Bootstrap::Breadcrumb
  before_filter :init_breadcrumb, :except => :destroy

  #common action here
  def get_tree
    mo_str = params[:model_name] || 'Category'
    ztree_name = params[:ztree_name] || 'name'
    checked_ids = params[:checked_ids] || ''
    the_model = Object.const_get(mo_str)
    conditions = ''
    conditions += "name like '%#{params[:query]}%'" if params[:query]
    objs = the_model.where(conditions)
    opts = {
      name: ztree_name,
      checked_ids: checked_ids
    }
    _query_ancestry_tree(objs, opts)
  end

  def sort_tree
    return render text: 'error' unless params[:model_name]
    mo_str = params[:model_name]
    the_model = Object.const_get(mo_str)
    arr = params[:sorted_array]
    p_id = arr.shift
    parent = p_id != '0' ? the_model.find(p_id) : the_model
    parent.update_sorted_numbers(arr)
    render text: arr
  end

  def delete_check
    return unless params[:checked_ids]
    the_model = Object.const_get(params[:model_name])
    the_model.destroy(params[:checked_ids].reject{|s| s.empty?})
    render text: 'OK'
  end

  def to_utf8(str)
    str.to_s.encode("UTF-8", :undef => :replace, :replace => "?", :invalid => :replace).chars.select{|i| i.valid_encoding?}.join
  end

  def purify_text(text)
    Sanitize.clean(Sanitize.clean(to_utf8(text))).gsub(/\s+/, '').gsub(/[   　.]/,'')
  end

  protected

    # 导航栏
    def init_breadcrumb(options = {})
      controller_str = controller_name
      if ['sessions', 'registrations', 'home'].include?(controller_name)
        return no_breadcrumbs
      end
      #drop_breadcrumb t("breadcrumb.admin.home_page"), root_url
      yield if block_given?
      case params[:action]
      when 'create'
        params[:action] = 'new'
      when 'update'
        params[:action] = 'edit'
      when 'destroy'
        params[:action] = 'index'
      end
      # drop_breadcrumb options[:index] || (t("models.#{controller_str.singularize}")<<"列表"), url_for(:action => :index)
      begin
        unless t("models.#{controller_str.singularize}").length == 0
          # binding.pry
          url_for(:action => :index)
          drop_breadcrumb(options[:index] || (t("models.#{controller_str.singularize}")<<""), url_for(:action => :index))
        end
      rescue Exception => ex
        p ex.message
        # 如果这个controller没有index这个action直接现实controller对应的中文名称-链接就是action的链接
        drop_breadcrumb(t("breadcrumb.controller.#{controller_str.singularize}"), url_for(:controller=>controller_name, :action => params[:action]) )


      end
      if params[:action] != 'index'
        drop_breadcrumb options[params[:action].to_sym] || t("breadcrumb.#{controller_str}.#{params[:action]}", :default => t("breadcrumb.defaults.#{params[:action]}")), url_for(:action => params[:action])
      end
    end

    def _write_log(object, desc, options = {})
      options.merge!({:ip => "#{request.remote_ip}|#{IPParse.parse(request.remote_ip).gsub("Unknown", "未知")}"})
      OperateLog.write(object, desc, current_user, options)
    end

    def flash_msg(status = :notice, msg = "")
      flash[status] = msg
    end

    def after_sign_out_path_for(resource_or_scope)
      request.referrer
    end

    def after_sign_in_path_for(resource)
      #UserMailer.welcome(current_user).deliver if current_user.admin?
      params[:back] || stored_location_for(resource) || root_path
      #(current_user.admin? ? admin_path : root_path)
    end

    def _render_404
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end

    # 为ie附件下载获取正确文件名
    def _file_name_for_agent(name)
      user_agent = request.user_agent.downcase
      file_name = user_agent.include?("msie") ? CGI::escape(name) : name
    end

    def _query_ancestry_tree(objs, opts = {})
       render :text => objs.to_ztree_node(opts).to_json
    end

    def redirect_with_message(*args)
      msg, opts = args[0], args.extract_options!
      raise '必须指定一个action' unless opts.has_key?(:action)
      flash[opts[:msg_type] || :notice] = msg if msg.is_a?String
      redirect_to opts
    end

end
