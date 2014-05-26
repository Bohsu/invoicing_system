# -*- encoding : utf-8 -*-
Date::DATE_FORMATS[:default] = "%Y-%m-%d"
Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M:%S"

ActiveRecord::Base.send :include, SortTree

# 生成16位的项目编号
def build_code
  SecureRandom.hex(8).scan(/.{4}/).join("-").upcase
end