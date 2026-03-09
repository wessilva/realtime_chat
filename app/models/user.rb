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
end
