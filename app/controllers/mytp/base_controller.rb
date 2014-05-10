# -*- encoding : utf-8 -*-

class Mytp::BaseController < AuthorizedController

  layout "admin_content"
  
  protected

  def init_breadcrumb(options = {})
    controller_str = params[:controller].gsub('/', '.').split('.')[1]
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
    drop_breadcrumb options[:index] || (t("models.#{controller_str.singularize}")<<"列表"), url_for(:action => :index)
    if params[:action] != 'index'
      drop_breadcrumb options[params[:action].to_sym] || t("breadcrumb.#{controller_str}.#{params[:action]}", :default => t("breadcrumb.defaults.#{params[:action]}")), url_for(:action => params[:action])
    end
  end

  def respond_back(object, url = nil)
    params[:back] = url || send("mytp_#{object.class.to_s.tableize}_url") if params[:back].blank?
    respond_with :mytp, object, :location => params[:back]
  end

  def include_area_search_params
    params[:search] ||= {}
    params[:search][:area_id_in] = (params[:area_id].present? && params[:subtree].present?) ? Area.find_by_id(params[:area_id]).try(:subtree_ids) : nil
    params[:search][:area_id_eq] = (params[:area_id].present? && !params[:subtree].present?) ? params[:area_id] : nil
  end

  def self._load_resource(instance_name = nil, instance_class = nil)
    before_filter { |c| c.load_resources(instance_name, instance_class) }
  end

  def load_resources(instance_name, instance_class)
    instance_name ||= self.class.to_s.sub("Controller", "").underscore.split('/').last.singularize
    instance_class ||= self.class.to_s.sub("Controller", "").underscore.split('/').last.singularize.camelize.classify.constantize
    if [:new, :create].include?(params[:action].to_sym)
      self.instance_variable_set("@#{instance_name}", instance_class.new)
    elsif params[:id]
      self.instance_variable_set("@#{instance_name}", instance_class.find_by_id(params[:id]))
    end
  end
end




