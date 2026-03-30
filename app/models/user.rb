class User < ApplicationRecord

  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         #Associação polimórfica com contatos
  has_many :contacts, dependent: :destroy

  has_many :conversants, dependent: :destroy

  has_many :admin_groups, class_name: 'Group', foreign_key: 'admin_id'

  has_many :added_users, through: :contacts, source: :contactable, source_type: 'User'
  has_many :added_groups, through: :contacts, source: :contactable, source_type: 'Group'

  def self.find_users(search_item)
    begin   
      users = where("name ~* :s OR email ~* :s", {s: search_item })

      return nil if users.empty?
      return users

    rescue => exception
        return nil
    end
  end
 
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end
end
