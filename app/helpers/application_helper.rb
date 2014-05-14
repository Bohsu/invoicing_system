# -*- encoding : utf-8 -*-

module ApplicationHelper
  # 加载css: <%= stylesheets 'my1','my2' %>
  def stylesheets(*args)
    stylesheet_link_tag(*args)
  end

  # 加载js: <%= javascripts 'my1','my2' %>
  def javascripts(*args)
    javascript_include_tag(*args)
  end

  def include_my97
    javascripts "/plugins/My97DatePicker/WdatePicker.js"
  end
  
  # 在新窗口打开链接
  def link_to_blank(*args, &block)
    if block_given?
      args = [(args.first || {}), (args.second || {}).merge(:target => '_blank')]
    else
      args = [(args.first || {}), (args.second || {}), (args.third || {}).merge(:target => '_blank', :title => args.first)]
    end
    link_to(*args, block)
  end

  # 下拉选择框
  def art_select(to_id, rs,  url, options = {})
    options.merge!({:class => 'drop_select', :readonly => "readonly", :dropdata => url})
    options[:droplimit] ||= "0"
    options[:droptree] ||= "true"
    input_id = to_id.gsub('[', "_").gsub(']', '_')
    if rs.blank?
      name_value = id_value = ""
    elsif rs.class == Array
      name_value = rs.map(&:name).join(",")
      id_value = rs.map(&:id).join(",")
    elsif options[:from] == 'ArticleType'
      name_value = rs.split(',').map{|artid| ArticleType.find(artid).name}.join(',').to_s
      id_value = rs
    else
      name_value = rs.name
      id_value = rs.id
    end
    name_value = options[:str] if options[:str]
    (text_field_tag("art_#{to_id}", name_value, options.merge({:id => "art_#{input_id}"})) + hidden_field_tag(to_id, id_value, :droptree_id => "art_#{input_id}" )).html_safe
  end

  #  无限级联下拉框 搭配js
  def dynamic_selects(data_class, value_id, aim_id, text_id = '', prompt = '请选择', options = {})
    options.merge!({:class => 'multi-level', :otype => data_class.to_s, :aim_id => aim_id, :text_id => text_id })
    value_object = data_class.find_by_id(value_id)
    select_text = value_object.try(:has_children?) ? collection_select('value_object-parent-id', 0, value_object.children, :id, :name, {:selected => value_object.try(:id), :prompt => prompt}, options) : ''
    #aim_id = object.class.to_s.tableize.singularize + "_" + ref.to_s.singularize + "_id"
    aim_id = aim_id.to_s
    while value_object and value_object.parent
      select_text = collection_select('value_object-parent-id', value_object.id, value_object.parent.children, :id, :name, {:selected => value_object.try(:id), :prompt => prompt}, options) << select_text
      value_object = value_object.parent
    end
    select_text = collection_select('value_object-parent-id', 0, data_class.roots, :id, :name, {:selected => value_object.try(:id), :prompt => prompt}, options) << select_text

    raw select_text
  end

  # 温馨提示
  def tips(*args)
    content_tag(:div, :class => "alert alert-info") do
      content_tag(:h5, "小贴士：", :class => "alert-heading") <<
        content_tag(:ol) do
          args.map{|arg| concat content_tag(:li, arg) }
        end
    end
  end

  # 根据状态显示信息
  def show_msg(status)
    case status.to_sym
      when :error
        "操作失败！"
      when :success
        "操作成功！"
      when :notice
        "温馨提示："
    end
  end

  #simple_form 国际化
  def simple_form_cn(col,lb='defaults')
    c = col == "area_id" ? col : col.gsub(/_id$/, '')
    v = I18n.t "simple_form.labels.#{lb}.#{c}"
    v = I18n.t "simple_form.labels.defaults.#{c}" if lb != 'defaults' && v.include?("translation missing:")
    return v.include?("translation missing:") ? col : v
  end

  # 渲染fusioncharts （图表文件别名，数据文件路径，数据字符，图标id，图表宽度，图表高度）
  # str_url,str_xml两者选其一，数据源
  def render_chart(chart_alias, str_url, str_xml, chart_id, chart_width, chart_height)
    chart_width = chart_width.to_s
    chart_height = chart_height.to_s
    html = ""
    html << "#{content_tag("div", "\n\t\t\t\tChart.\n\t\t", {:id=>chart_id+"_div", :align=>"center"})}"
    html << "<script type='text/javascript'>"
    html << "var chart_#{chart_id} = new FusionCharts('#{chart_alias}','#{chart_id}',#{chart_width},#{chart_height},'0','1'); "
    if str_url == ""
      html << "chart_#{chart_id}.setDataXML(\"#{str_xml}\");"
    else
      html << "chart_#{chart_id}.setDataURL(unescape('#{str_url}'));"
    end
    html << "chart_#{chart_id}.render('#{chart_id}_div');"
    html << "</script>"
    html.html_safe
  end

  # 菜单选中状态
  def link_to_menu(title, url, options = {})
    options[:on] ||= []
    options[:on] << url
    options[:class] = "on" if options[:on].include? request.path
    link_to(title, url, options)
  end

  # 生成列表序号
  def index_no(index, per = 30)
    params[:page] ||= 1
    (params[:page].to_i - 1) * per + index + 1
  end

  # admin edit and destroy links
  def operate_buttons(object, options = {}, &block)
    lis = ""
    if object.is_a?(Array)
      lis = object.map{|link| "<li>#{link}</li>" }.join("")
    elsif object.present?
      options[:namespace] = "mytp" if options[:namespace].nil?
      namespace = options[:namespace]
      links = []
      edit_path = eval("#{['edit', namespace, object.class.to_s.tableize.singularize, 'path'].compact.join('_')}(#{object.id},:back => request.fullpath)")
      destroy_path = eval("#{[namespace, object.class.to_s.tableize.singularize, 'path'].compact.join('_')}(#{object.id},:back => request.fullpath)")

      links << link_to('修改', edit_path)
      links << link_to('删除', destroy_path, :method => 'delete', :confirm =>'您确定吗？')
      links += options[:links] if options[:links].present?
      lis = links.map{|link| "<li>#{link}</li>" }.join("")
      if block_given?
        lis << capture(&block)
      end
    end
    html = %Q|
      <div class="btn-group">
        <button class="btn btn-primary btn-small dropdown-toggle" data-toggle="dropdown">操作<span class="caret"></span></button>
        <ul class="dropdown-menu">
          #{lis}
        </ul>
      </div>
    |.html_safe
  end

  # 显示日志
  def show_logs(object)
    record = OperateLog.find_by_logable_id_and_logable_type(object.id, object.class.to_s)
    unless record.nil?
      html = "<div>
      <p class='label label-important'>操作日志</p><table class='common table-bordered table-striped table-hover' id='logs_table'>
        <thead>
        <tr>
          <th>操作时间</th>
          <th>操作人姓名[编号]</th>
          <th>操作人单位</th>
          <th>操作内容</th>
          <!--<th style='width:100px;'>当前状态</th>-->
          <th style='width:140px;'>IP地址</th>
          <th>备注</th>
        </tr>
        </thead>"
      log_doc = Nokogiri::XML(record.details)
      log_doc.xpath('//log').each do |log|
      html << "<tr>
        <td>&nbsp;#{log.attr('操作时间')} </td>
        <td>&nbsp;#{log.attr('操作人姓名')}[#{log.attr('操作人ID')}]</td>
        <td>&nbsp;#{log.attr('操作人单位')}</td>
        <td>&nbsp;#{log.attr('操作内容')}</td>
        <td>&nbsp;#{log.attr('IP地址')}</td>
        <td>&nbsp;#{log.attr('备注')}</td></tr>"
      end
      html << "</table></div>"
      return html.html_safe
    end
  end

  def check_all_selector(selector = 'select_all')
    check_box_tag selector, '', false, onclick: 'select_all_records()'
  end

  def primary_btn
    'btn btn-primary btn-small'
  end

  # 必须项，红星
  def require_span
    "<span class='red'>* </span>".html_safe
  end

  def multiple_delete_btn(opts)
    content_tag :div, '删除选中项', opts.merge(class: primary_btn + ' ml10', id: 'delete_check')
  end

  # 弹出框展示图片
  def art_image_link(title, url, options = {})
    options['class'] = 'art_image_show'
    options['onclick'] = "art_image_show('#{url}');"
    link_to title, "javascript:void(0);", options
  end

  # 返回
  def link_back
    link_to "<- 返回", request.env["HTTP_REFERER"].blank? ? "/" : request.env["HTTP_REFERER"], class: 'btn btn-warning btn-small'
  end

  # 截取包含汉字英文数组字符串
  def truncate_u(text, length = 30, truncate_string = "...")
    # text = text.html_safe
    l=0
    char_array=text.unpack("U*")
    char_array.each_with_index do |c,i|
      l = l+ (c<127 ? 0.5 : 1)
      if l>=length
        return char_array[0..i].pack("U*")+(i<char_array.length-1 ? truncate_string : "")
      end
    end
    return text
  end

  def to_utf8(str)
    str.to_s.encode("UTF-8", :undef => :replace, :replace => "?", :invalid => :replace).chars.select{|i| i.valid_encoding?}.join
  end

  def purify_text(text)
    Sanitize.clean(Sanitize.clean(to_utf8(text))).gsub(/\s+/, '').gsub(/[   　.]/,'')
  end

end
