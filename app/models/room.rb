class Room < ApplicationRecord
  has_many :conversants, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false}

  has_many :messages, as: :messageable, dependent: :destroy

  def self.create_nomed_room(users, room_name)
    room = Room.create(name: room_name)

    users.each do |user|
      Conversant.create(user_id: user.id, room_id: room.id)
    end

    return room
    
  end
end
