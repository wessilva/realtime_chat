class Group < ApplicationRecord

  has_one_attached :avatar

  belongs_to :admin, class_name: 'User',  foreign_key: 'admin_id'

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_many :contacts, as: :contactable, dependent: :destroy

   def self.find_groups(search_item)

        begin
           groups = where("name ~* :s", {s: search_item })
           return nil if groups.empty?
           return groups
     
         rescue => exception
             return nil
         end
     
     end
end
