class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :login, :name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :permission_users, :dependent => :delete_all
  has_many :permissions, :through => :permission_users

   # 该用户所拥有的所有菜单
  def menus
    Permission.menus
  end

end
