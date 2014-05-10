# -*- encoding : utf-8 -*-

module XmlParser

  class Nokogiri::XML::Element
    alias_method :get_a, :get_attribute
    alias_method :set_a, :set_attribute
  end

  def find_param_node(doc, name)
    _get_node(doc.root.elements, name)
  end

  def find_select_value(data_element, select_name)
    _get_node(data_element, select_name, 'select')
  end

  def add_element(parent, tag)
    parent.add_child tag
    parent.elements.last
  end

  def read_data_from_xml(xml, pas)
    param_doc = Nokogiri::XML(xml)
    new_doc = Nokogiri::XML('<?xml version="1.0" encoding="utf-8" ?><root></root>')
    param_doc.root.elements.each do |element|
      next if element.get_a("show") == "4"
      if element.get_a("type") == "下拉型"
        node = add_element new_doc.root, "<param>"
        node.set_a("name", element.get_a("name"))
        element.elements.each do |select|
          s_node = add_element node, "<select>"
          s_node.set_a("name", select.get_a("name"))
          s_node.set_a("value", (pas["#{element.get_a('name').to_en}"]["'#{element.get_a('name').to_en}'"] rescue nil)) # wait to debug
        end
      else
        node = add_element(new_doc.root, "<param>")
        node.set_a("name", element.get_a("name"))
        node.set_a("value", pas["#{element.get_a('name').to_en}"])
      end
    end

    new_doc.to_xml
  end

  private

    def _get_node(eles, val, tag_name = 'param')
      eles.search(tag_name).each {|r| return r if r.get_attribute('name') == val}
    end
end
