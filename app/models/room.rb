class Room < ApplicationRecord
  has_many :conversants, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false}
end
