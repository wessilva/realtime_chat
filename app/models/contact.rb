class Contact < ApplicationRecord
  belongs_to :user

  belongs_to :contactable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:contactable_id, :contactable_type]}
end
