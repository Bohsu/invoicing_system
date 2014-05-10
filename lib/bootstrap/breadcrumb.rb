# encoding: utf-8

module Bootstrap
  module Breadcrumb
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
      receiver.send :helper, Helpers
      receiver.send :before_filter, :set_breadcrumbs
    end

    module ClassMethods

    end

    module InstanceMethods
      protected

      def set_breadcrumbs
        @breadcrumbs = ["当前位置：<a href='/'>首页</a>".html_safe]
      end

      def drop_breadcrumb(title=nil, url=nil)
        title ||= @page_title
       # url ||= url_for
        if title
          if url
            @breadcrumbs.push("<a href=\"#{url}\">#{title}</a>".html_safe)
          else
            @breadcrumbs.push("<h1>#{title}</h1>".html_safe)
          end
        end
      end

      def drop_page_title(title)
        @page_title = title
        return @page_title
      end

      def no_breadcrumbs
        @breadcrumbs = []
      end
    end

    module Helpers

      def render_breadcrumb
        return "" if @breadcrumbs.size <= 0
        crumb = "".html_safe

        @breadcrumbs.each_with_index do |c, i|

          if i == (@breadcrumbs.length - 1)
            breadcrumb_content = c
          else
            breadcrumb_content = c + " >> "
          end

          crumb += breadcrumb_content
        end
        return crumb
      end
    end
  end
end
